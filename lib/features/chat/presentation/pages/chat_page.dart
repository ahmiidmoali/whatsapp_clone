import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/features/app/const/page_const.dart';
import 'package:whatsapp_clone/features/app/global/data/date_formats.dart';
import 'package:whatsapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';
import 'package:whatsapp_clone/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp_clone/features/chat/domain/entities/message_entity.dart';
import 'package:whatsapp_clone/features/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:whatsapp_clone/features/chat/presentation/pages/single_chat_page.dart';

class ChatPage extends StatefulWidget {
  final String uid;
  const ChatPage({super.key, required this.uid});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context)
        .getMyChat(chat: ChatEntity(senderUid: widget.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is ChatLoaded) {
          final chats = state.chatContacts;
          if (chats.isEmpty) {
            return const Center(
              child: Text(
                "there is no chats ",
                style: TextStyle(color: whiteColor),
              ),
            );
          }
          return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(PageConst.singleChatPage,
                        arguments: MessageEntity(
                            senderUid: chat.senderUid,
                            recipientUid: chat.recipientUid,
                            senderName: chat.senderName,
                            recipientName: chat.recipientName,
                            senderProfile: chat.senderProfile,
                            recipientProfile: chat.recipientProfile));
                  },
                  child: ListTile(
                    leading: SizedBox(
                      height: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: profileWidget(),
                      ),
                    ),
                    title: Text(
                      "${chat.recipientName}",
                      style: const TextStyle(
                          color: whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      "${chat.recentTextMessage}",
                      style: const TextStyle(
                          color: greyColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: Text(
                      DateFormat.jm().format(chat.createdAt!.toDate()),
                      style: const TextStyle(
                          color: greyColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: tabColor,
            ),
          );
        }
      },
    ));
  }
}
