import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/features/app/const/page_const.dart';
import 'package:whatsapp_clone/features/app/global/widgets/dialog_widget.dart';
import 'package:whatsapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/auth/cubit/auth_cubit.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/get_single_user/cubit/get_single_user_cubit.dart';

class SettingsPage extends StatefulWidget {
  final String uid;
  const SettingsPage({super.key, required this.uid});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: greyColor,
              )),
          title: const Text(
            "Settings",
            style: TextStyle(
                color: whiteColor, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: Column(
          children: [
            BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
              builder: (context, state) {
                if (state is GetSingleUserLoaded) {
                  final singleUser = state.singleUser;
                  return SettingsProfileInfo(
                    onTap: () {
                      Navigator.of(context).pushNamed(PageConst.editProfilePage,
                          arguments: singleUser);
                    },
                    username: singleUser.username!,
                    status: singleUser.status!,
                    url: singleUser.profileUrl!,
                  );
                } else {
                  return const SettingsProfileInfo(
                    username: "...",
                    status: "...",
                    url: "",
                  );
                }
              },
            ),
            const Divider(
              thickness: .3,
              color: whiteColor,
            ),
            SettingsListileField(
              icon: Icons.key,
              onTap: () {},
              title: "Account",
              subtitle: "Security Applications,change number",
            ),
            SettingsListileField(
              icon: Icons.lock_clock,
              onTap: () {},
              title: "Privacy",
              subtitle: "Block contacts,disappearing messages ",
            ),
            SettingsListileField(
              icon: Icons.chat,
              onTap: () {},
              title: "chats",
              subtitle: "Theme,wallpapers,chat history",
            ),
            SettingsListileField(
              icon: Icons.logout,
              onTap: () {
                displayAlertDialog(
                  context,
                  confirmTitle: "Logout",
                  content: "Are you sure you want to logout?",
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context).loggedOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      PageConst.welcomePage,
                      (route) => false,
                    );
                  },
                );
              },
              title: "Logout",
              subtitle: "Logout from WhatsApp Clone",
            )
          ],
        ));
  }
}

class SettingsProfileInfo extends StatelessWidget {
  final String username;
  final String status;
  final String url;
  final void Function()? onTap;
  const SettingsProfileInfo({
    super.key,
    required this.username,
    required this.status,
    required this.url,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: SizedBox(
          height: 60,
          width: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: profileWidget(imageUrl: url),
          ),
        ),
        title: Text(
          username,
          style: const TextStyle(
              color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          status,
          style: const TextStyle(
              color: greyColor, fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class SettingsListileField extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final String subtitle;
  final IconData? icon;
  const SettingsListileField(
      {super.key,
      required this.onTap,
      required this.title,
      required this.subtitle,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(
              color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
              color: greyColor, fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
