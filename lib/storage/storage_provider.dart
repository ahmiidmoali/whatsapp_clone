import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageProviderRemoteDataSource {
  static FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String> uploadProfileImage(
      {required File file, Function(bool isUploading)? onComplete}) async {
    onComplete!(true);
    final Reference ref = _storage
        .ref()
        .child("profile/${DateTime.now().millisecondsSinceEpoch}");
    final UploadTask uploadTask = ref.putData(
        await file.readAsBytes(), SettableMetadata(contentType: 'image/png'));

    final imageUrl = (await uploadTask.whenComplete(
      () {},
    ))
        .ref
        .getDownloadURL();
    onComplete(false);
    return imageUrl;
  }

  static Future<String> uploadMessageFile(
      {required File file,
      Function(bool isUploading)? onComplete,
      String? uid,
      String? otherUid,
      String? type}) async {
    onComplete!(true);

    final ref = _storage.ref().child(
        "message/$type/$uid/$otherUid/${DateTime.now().millisecondsSinceEpoch}");

    final uploadTask = ref.putData(
      await file.readAsBytes(),
      SettableMetadata(contentType: 'image/png'),
    );

    final imageUrl =
        (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    onComplete(false);
    return await imageUrl;
  }
}
