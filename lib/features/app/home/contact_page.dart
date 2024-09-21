import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/get_device_number/cubit/get_device_number_cubit.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/user/cubit/user_cubit.dart';

class ContactPage extends StatefulWidget {
  final String uid;
  const ContactPage({super.key, required this.uid});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  void initState() {
    // BlocProvider.of<GetDeviceNumberCubit>(context).getDeviceNumber();
    BlocProvider.of<UserCubit>(context).getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Select Contants",
            style: TextStyle(
                color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: greyColor,
              )),
        ),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoaded) {
              final users = state.user
                  .where(
                    (user) => user.uid != widget.uid,
                  )
                  .toList();
              if (users.isEmpty) {
                return const Center(
                  child: Text(
                    "there is no contacts ",
                    style: TextStyle(color: whiteColor),
                  ),
                );
              }
              return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigator.of(context).
                      },
                      child: ListTile(
                        leading: SizedBox(
                          height: 60,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: profileWidget(imageUrl: user.profileUrl)),
                        ),
                        title: Text(
                          "${user.username} ",
                          style: const TextStyle(
                              color: whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          "${user.status} ",
                          style: const TextStyle(
                              color: greyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  });
            }
            return const CircularProgressIndicator(
              color: tabColor,
            );
          },
        ));
  }
}

// FIXME: tillUsingRealPhone 
// BlocBuilder<GetDeviceNumberCubit, GetDeviceNumberState>(
//           builder: (context, state) {
//             if (state is GetDeviceNumberLoaded) {
//               final contacts = state.contacts;
//               if (contacts.isEmpty) {
//                 return const Text(
//                   "there is no contacts ",
//                   style: TextStyle(color: whiteColor),
//                 );
//               }
//               return ListView.builder(
//                   itemCount: contacts.length,
//                   itemBuilder: (context, index) {
//                     final contact = contacts[index];
//                     return GestureDetector(
//                       onTap: () {
//                         // Navigator.of(context).
//                       },
//                       child: ListTile(
//                         leading: SizedBox(
//                           height: 60,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(60),
//                             child: Image.memory(
//                               contact.photo ?? Uint8List(0),
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Image.asset(
//                                     'assets/profile_default.png');
//                               },
//                             ),
//                           ),
//                         ),
//                         title: Text(
//                           "${contact.name!.first} ${contacts[index].name!.nickname} ",
//                           style: const TextStyle(
//                               color: whiteColor,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         subtitle: const Text(
//                           "hey there!i'm using whatsapp ",
//                           style: TextStyle(
//                               color: greyColor,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     );
//                   });
//             }
//             return const CircularProgressIndicator(
//               color: tabColor,
//             );
//           },
//         )