import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:whatsapp_clone/features/app/const/message_type_const.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';
import 'package:whatsapp_clone/features/chat/domain/entities/message_reply_entity.dart';
import 'package:whatsapp_clone/features/chat/presentation/widgets/message_widgets/message_replay_type_widget.dart';
import 'package:whatsapp_clone/features/chat/presentation/widgets/message_widgets/message_type_widget.dart';

class MessageLayout extends StatelessWidget {
  final Color messageBgColor;
  final Alignment? alignment;
  final Timestamp createAt;
  final VoidCallback? onSwipe;
  final String message;
  final bool isShowTick;
  final bool isSeen;
  final VoidCallback? onLongPress;
  final String? messageType;
  final MessageReplayEntity? reply;
  final double? rightPadding;
  final String? recipientName;
  const MessageLayout(
      {super.key,
      required this.messageBgColor,
      required this.alignment,
      required this.createAt,
      required this.onSwipe,
      required this.message,
      required this.isShowTick,
      required this.isSeen,
      required this.onLongPress,
      required this.messageType,
      this.reply,
      this.rightPadding,
      this.recipientName});

  @override
  Widget build(BuildContext context) {
    const defaultPadding = 5.0;
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: SwipeTo(
          onRightSwipe: (details) {
            onSwipe?.call();
          },
          child: GestureDetector(
            onLongPress: onLongPress,
            child: Container(
                alignment: alignment,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: messageType == MessageTypeConst.textMessage
                                ? rightPadding!
                                : defaultPadding,
                            top: 3,
                            bottom: 3,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: messageBgColor),
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * .8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              reply?.message == null || reply?.message == ""
                                  ? const SizedBox()
                                  : Container(
                                      height: reply!.messageType ==
                                              MessageTypeConst.textMessage
                                          ? 70
                                          : 80,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: double.infinity,
                                            width: 4.5,
                                            decoration: BoxDecoration(
                                                color: reply!.username ==
                                                        recipientName
                                                    ? Colors.deepPurpleAccent
                                                    : tabColor,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(15),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                15))),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${reply?.username == recipientName ? reply!.username : "You"}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: reply!
                                                                    .username ==
                                                                recipientName
                                                            ? Colors
                                                                .deepPurpleAccent
                                                            : tabColor),
                                                  ),
                                                  MessageReplayTypeWidget(
                                                    message: reply!.message,
                                                    type: reply!.messageType,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              const SizedBox(
                                height: 3,
                              ),
                              MessageTypeWidget(
                                message: message,
                                type: messageType,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        top: 10,
                        right: 10,
                        child: Row(
                          children: [
                            Text(
                              DateFormat.jm().format(createAt.toDate()),
                              style: const TextStyle(
                                  fontSize: 10, color: greyColor),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            const Icon(
                              Icons.done,
                              size: 13,
                              color: greyColor,
                            )
                          ],
                        ))
                  ],
                )),
          )),
    );
  }
}
