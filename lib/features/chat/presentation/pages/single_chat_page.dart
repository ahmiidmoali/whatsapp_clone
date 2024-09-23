import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/features/app/const/message_type_const.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';
import 'package:whatsapp_clone/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp_clone/features/chat/domain/entities/message_entity.dart';
import 'package:whatsapp_clone/features/chat/presentation/cubit/message/message_cubit.dart';
import 'package:whatsapp_clone/features/chat/presentation/cubit/rebuild/chat_rebuild_cubit.dart';
import 'package:whatsapp_clone/features/chat/presentation/widgets/chat_attached_widget.dart';
import 'package:whatsapp_clone/features/chat/presentation/widgets/chat_message_layout.dart';
import 'package:whatsapp_clone/features/chat/presentation/widgets/chat_textfield_widget.dart';

class SingleChatPage extends StatefulWidget {
  final MessageEntity message;
  const SingleChatPage({super.key, required this.message});

  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  late TextEditingController messageController;
  bool _isVisible = false;
  bool _isTyping = false;
  @override
  void initState() {
    messageController = TextEditingController();
    BlocProvider.of<MessageCubit>(context).getMessages(
        message: MessageEntity(
            senderUid: widget.message.senderUid,
            recipientUid: widget.message.recipientUid));
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ListTile(
            title: Text(
              "${widget.message.recipientName}",
              style: const TextStyle(
                  color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            subtitle: const Text(
              "            Online",
              style: TextStyle(
                color: whiteColor,
                fontSize: 12,
              ),
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: greyColor,
              )),
          // ignore: prefer_const_literals_to_create_immutables
          actions: [
            const Icon(Icons.videocam_rounded),
            const SizedBox(
              width: 20,
            ),
            const Icon(
              Icons.call,
              color: greyColor,
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.more_vert,
              color: greyColor,
            ),
          ],
        ),
        body: BlocBuilder<MessageCubit, MessageState>(
          builder: (context, state) {
            if (state is MessageLoaded) {
              final messages = state.messages;
              return Stack(
                children: [
                  Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Image.asset(
                        "assets/whatsapp_bg_image.png",
                        fit: BoxFit.cover,
                      )),
                  GestureDetector(
                    onTap: () {
                      if (_isVisible) {
                        BlocProvider.of<ChatRebuildCubit>(context)
                            .toggleShowAttachWindow();
                      }
                    },
                    child: Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            if (message.senderUid == widget.message.senderUid) {
                              return MessageLayout(
                                messageBgColor: messageColor,
                                alignment: Alignment.centerRight,
                                createAt: Timestamp.now(),
                                onSwipe: () {},
                                message: message.message!,
                                isShowTick: true,
                                isSeen: true,
                                onLongPress: () {},
                              );
                            } else {
                              return MessageLayout(
                                messageBgColor: senderMessageColor,
                                alignment: Alignment.centerLeft,
                                createAt: Timestamp.now(),
                                onSwipe: () {},
                                message: message.message!,
                                isShowTick: true,
                                isSeen: true,
                                onLongPress: () {},
                              );
                            }
                          },
                        )),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // ChatTextfieldWidget--------------------------------------
                            Expanded(
                                child: ChatTextfieldWidget(
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  BlocProvider.of<ChatRebuildCubit>(context)
                                      .toggleSendButton(value);
                                } else {
                                  BlocProvider.of<ChatRebuildCubit>(context)
                                      .toggleSendButton(value);
                                }
                              },
                              controller: messageController,
                              onClickAttached: () {
                                BlocProvider.of<ChatRebuildCubit>(context)
                                    .toggleShowAttachWindow();
                              },
                            )),
                            // send &record button--------------------------------------
                            BlocBuilder<ChatRebuildCubit, ChatRebuildState>(
                              builder: (context, state) {
                                _isTyping = state.isDisplaySendButton;
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(40)),
                                      color: tabColor),
                                  child: IconButton(
                                      onPressed: () {
                                        if (messageController.text.isNotEmpty) {
                                          _sendMessage();
                                        }
                                      },
                                      icon: Icon(
                                        _isTyping ? Icons.send : Icons.mic,
                                        color: whiteColor,
                                        size: 30,
                                      )),
                                );
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<ChatRebuildCubit, ChatRebuildState>(
                    builder: (context, state) {
                      if (state.isShowAttachWindow) {
                        _isVisible = true;
                        return const Positioned(
                            right: 1,
                            top: 350,
                            left: 50,
                            bottom: 2,
                            child: AttachedWidget());
                      } else {
                        _isVisible = false;
                        return const SizedBox(
                          height: 0,
                        );
                      }
                    },
                  )
                ],
              );
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

  void _sendMessage() {
    BlocProvider.of<MessageCubit>(context)
        .sendMessage(
            chat: ChatEntity(
                createdAt: Timestamp.now(),
                senderName: widget.message.senderName,
                senderProfile: widget.message.senderProfile,
                senderUid: widget.message.senderUid,
                recipientName: widget.message.recipientName,
                recipientUid: widget.message.recipientUid,
                recipientProfile: widget.message.recipientProfile,
                totalUnReadMessages: 0),
            message: MessageEntity(
                createdAt: Timestamp.now(),
                isSeen: false,
                message: messageController.text,
                messageType: MessageTypeConst.textMessage,
                recipientUid: widget.message.recipientUid,
                recipientName: widget.message.recipientName,
                senderUid: widget.message.senderUid,
                senderName: widget.message.senderName,
                repliedMessage: "",
                repliedMessageType: "",
                repliedTo: ""))
        .then(
      (value) {
        messageController.clear();
      },
    );
  }
}
