import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
            style: const TextStyle(
                color: whiteColor, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: Column(
          children: [
            ListTile(
              leading: SizedBox(
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: profileWidget(),
                ),
              ),
              title: const Text(
                "Username",
                style: TextStyle(
                    color: whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              subtitle: const Text(
                "hey there!i'm using whatsapp ",
                style: TextStyle(
                    color: greyColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
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
              onTap: () {},
              title: "Logout",
              subtitle: "Logout from WhatsApp Clone",
            )
          ],
        ));
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
