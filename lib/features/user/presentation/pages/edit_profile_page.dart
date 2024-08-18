import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/user/domain/entities/user_entitiy.dart';

class EditProfilePage extends StatefulWidget {
  final UserEntity singleUser;
  const EditProfilePage({super.key, required this.singleUser});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("dfdfdfdf"),
      ),
    );
  }
}
