import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/global/data/date_formats.dart';
import 'package:whatsapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';
import 'package:whatsapp_clone/features/chat/presentation/pages/single_chat_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SingleChatPage(),
          ));
        },
        child: ListTile(
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
                color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          subtitle: const Text(
            "last message : hi",
            style: TextStyle(
                color: greyColor, fontSize: 12, fontWeight: FontWeight.w500),
          ),
          trailing: Text(
            formatDateTime(DateTime.now()),
            style: const TextStyle(
                color: greyColor, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    ));
  }
}
