import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/features/app/const/app_const.dart';
import 'package:whatsapp_clone/features/app/home/home_page.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';
import 'package:whatsapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone/features/user/domain/entities/user_entitiy.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/auth/cubit/auth_cubit.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/credential/cubit/credential_cubit.dart';
import 'package:whatsapp_clone/storage/storage_provider.dart';

class InitialProfileSubmitPage extends StatefulWidget {
  final String phoneNumber;
  const InitialProfileSubmitPage({super.key, required this.phoneNumber});

  @override
  State<InitialProfileSubmitPage> createState() =>
      _InitialProfileSubmitPageState();
}

class _InitialProfileSubmitPageState extends State<InitialProfileSubmitPage> {
  late TextEditingController _usernameController;
  bool _isProfileUpdating = false;
  File? _image;
  Future selectImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("no image");
        }
      });
    } catch (e) {
      toast("some $e");
    }
  }

  @override
  void initState() {
    _usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          margin: const EdgeInsets.only(top: 40, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Profile Infor",
                  style: TextStyle(
                      color: tabColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                const Text(
                  "Please provide your name and an optional profile photo",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    selectImage();
                  },
                  child: SizedBox(
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: profileWidget(image: _image),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: TextField(
                    controller: _usernameController,
                    style: const TextStyle(color: whiteColor, fontSize: 20),
                    decoration: InputDecoration(
                        hintText: "Username",
                        hintStyle: TextStyle(
                            color: whiteColor.withOpacity(.6),
                            fontSize: 18,
                            fontWeight: FontWeight.w300),
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: tabColor))),
                  ),
                ),
                GestureDetector(
                  onTap: submitProfileInfo,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(5),
                    height: 40,
                    width: 180,
                    decoration: const BoxDecoration(
                        color: tabColor,
                        borderRadius: BorderRadius.all(Radius.circular(9))),
                    child: const Text(
                      "Next",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  submitProfileInfo() {
    if (_image != null) {
      StorageProviderRemoteDataSource.uploadProfileImage(
        file: _image!,
        onComplete: (onProfileUpdateComplete) {
          _isProfileUpdating = onProfileUpdateComplete;
        },
      ).then(
        (profileImageUrl) {
          _profileInfo(profileUrl: profileImageUrl);
        },
      );
    } else {
      _profileInfo(profileUrl: "");
    }
  }

  _profileInfo({required String profileUrl}) {
    if (_usernameController.text.isNotEmpty) {
      BlocProvider.of<CredentialCubit>(context).submitProfileInfo(
          user: UserEntity(
              uid: "",
              email: "",
              isOnline: false,
              phoneNumber: widget.phoneNumber,
              profileUrl: profileUrl,
              status: "Hey there i'm using Whatsapp Clone",
              username: _usernameController.text));
    }
  }
}
