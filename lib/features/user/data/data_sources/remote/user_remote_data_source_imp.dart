// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/features/app/const/app_const.dart';
import 'package:whatsapp_clone/features/app/const/firebase_collection_const.dart';

import 'package:whatsapp_clone/features/user/data/data_sources/remote/user_remote_data_source.dart';
import 'package:whatsapp_clone/features/user/data/models/user_model.dart';
import 'package:whatsapp_clone/features/user/domain/entities/contact_entity.dart';
import 'package:whatsapp_clone/features/user/domain/entities/user_entitiy.dart';

class UserRemoteDataSourceImp extends UserRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  String _verificationId = "";
  UserRemoteDataSourceImp({
    required this.firestore,
    required this.auth,
  });
  @override
  Future<void> createUser(UserEntity user) async {
    final userCollection = firestore.collection(FirebaseCollectionConst.users);

    final uid = await getCurrentUID();

    final newUser = UserModel(
            email: user.email,
            uid: uid,
            isOnline: user.isOnline,
            phoneNumber: user.phoneNumber,
            username: user.username,
            profileUrl: user.profileUrl,
            status: user.status)
        .toDocument();

    try {
      userCollection.doc(uid).get().then((userDoc) {
        if (!userDoc.exists) {
          userCollection.doc(uid).set(newUser);
        } else {
          userCollection.doc(uid).update(newUser);
        }
      });
    } catch (e) {
      throw Exception("Error occur while creating user");
    }
  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
    final userCollection = firestore.collection(FirebaseCollectionConst.users);
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Future<String> getCurrentUID() async => auth.currentUser!.uid;

  @override
  Future<List<ContactEntity>> getDeviceNumber() async {
    List<ContactEntity> contacts = [];
    final getContactsData = await ContactsService.getContacts();
    getContactsData.forEach(
      (myContact) {
        myContact.phones!.forEach(
          (numberData) {
            contacts.add(ContactEntity(
                lable: myContact.displayName,
                phoneNumber: numberData.value,
                userProfile: myContact.avatar));
          },
        );
      },
    );
    return contacts;
  }

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    final userCollection = firestore
        .collection(FirebaseCollectionConst.users)
        .where("uid", isEqualTo: uid);
    return userCollection.snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map(
                (e) => UserModel.fromSnapshot(e),
              )
              .toList(),
        );
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: smsPinCode);
      await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        toast("Invalid Verification Code");
      } else if (e.code == 'quota-exceeded') {
        toast("SMS quota-exceeded");
      }
    } catch (e) {
      toast("Unknown exception please try again");
    }
  }

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> updateUser(UserEntity user) async {
    final userCollection = firestore.collection(FirebaseCollectionConst.users);
    Map<String, dynamic> userInfo = {};
    if (user.username != null && user.username != "") {
      userInfo["username"] = user.username;
    }
    if (user.status != null && user.status != "") {
      userInfo["status"] = user.status;
    }
    if (user.profileUrl != null && user.profileUrl != "") {
      userInfo["profileUrl"] = user.profileUrl;
    }
    if (user.isOnline != null) userInfo["isOnline"] = user.isOnline;
    userCollection.doc(user.uid).update(userInfo);
  }

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    phoneVerificationCompleted(AuthCredential authCredential) {
      print(
          "phone verified : Token ${authCredential.token} ${authCredential.signInMethod}");
    }

    phoneVerificationFailed(FirebaseAuthException firebaseAuthException) {
      print(
        "phone failed : ${firebaseAuthException.message},${firebaseAuthException.code}",
      );
    }

    phoneCodeAutoRetrievalTimeout(String verificationId) {
      _verificationId = verificationId;
      print("time out :$verificationId");
    }

    phoneCodeSent(String verificationId, int? forceResendingToken) {
      _verificationId = verificationId;
    }

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: phoneVerificationCompleted,
      verificationFailed: phoneVerificationFailed,
      timeout: const Duration(seconds: 60),
      codeSent: phoneCodeSent,
      codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
    );
  }
}
