import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/features/app/const/app_const.dart';
import 'package:whatsapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';
import 'package:whatsapp_clone/features/user/domain/entities/user_entitiy.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/credential/cubit/credential_cubit.dart';
import 'package:whatsapp_clone/storage/storage_provider.dart';

class EditProfilePage extends StatefulWidget {
  final UserEntity singleUser;
  const EditProfilePage({super.key, required this.singleUser});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _userNameController;
  late TextEditingController _statusController;
  File? _image;
  bool _isProfileUpdating = false;
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
    _userNameController = TextEditingController(
      text: widget.singleUser.username,
    );
    _statusController = TextEditingController(text: widget.singleUser.status);
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.clear();
    _statusController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profile",
            style: TextStyle(color: whiteColor),
          ),
          iconTheme: const IconThemeData(color: whiteColor),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            alignment: Alignment.center,
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                        height: 150,
                        width: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(75),
                          child: profileWidget(
                              image: _image,
                              imageUrl: widget.singleUser.profileUrl),
                        )),
                    Positioned(
                        bottom: 2,
                        right: 10,
                        child: InkWell(
                          onTap: () {
                            selectImage();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: tabColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: blackColor,
                              size: 28,
                            ),
                          ),
                        ))
                  ],
                ),
                ProfileTextForm(
                  title: "profile",
                  icon: Icons.person,
                  controller: _userNameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                ProfileTextForm(
                  title: "About",
                  icon: Icons.info,
                  controller: _statusController,
                ),
                const SizedBox(
                  height: 20,
                ),
                ProfileNumberListile(
                  title: "phone",
                  icon: Icons.phone,
                  number: widget.singleUser.phoneNumber!,
                ),
                InkWell(
                  onTap: submitProfileInfo,
                  child: Container(
                    margin: const EdgeInsets.only(top: 40),
                    alignment: Alignment.center,
                    width: 140,
                    height: 40,
                    decoration: BoxDecoration(
                        color: tabColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      "Save",
                      style: TextStyle(color: whiteColor, fontSize: 18),
                    ),
                  ),
                )
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
    if (_userNameController.text.isNotEmpty &&
        _statusController.text.isNotEmpty) {
      BlocProvider.of<CredentialCubit>(context).submitProfileInfo(
          user: UserEntity(
              uid: "",
              email: "",
              isOnline: false,
              phoneNumber: widget.singleUser.phoneNumber,
              profileUrl: profileUrl,
              status: _statusController.text,
              username: _userNameController.text));
    }
  }
}

class ProfileTextForm extends StatelessWidget {
  final String title;
  final IconData? icon;
  final TextEditingController? controller;
  const ProfileTextForm(
      {super.key,
      required this.title,
      required this.icon,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: greyColor),
      ),
      subtitle: SizedBox(
        child: TextField(
          style: const TextStyle(color: whiteColor),
          controller: controller,
          decoration: const InputDecoration(
              suffixIcon: Icon(
            Icons.edit,
            color: tabColor,
          )),
        ),
      ),
      leading: Icon(
        icon,
        color: whiteColor,
      ),
    );
  }
}

class ProfileNumberListile extends StatelessWidget {
  final String title;
  final String number;
  final IconData? icon;

  const ProfileNumberListile({
    super.key,
    required this.title,
    required this.icon,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: greyColor),
      ),
      subtitle: Text(
        number,
        style: const TextStyle(color: whiteColor, fontSize: 18),
      ),
      leading: Icon(
        icon,
        color: whiteColor,
      ),
    );
  }
}
