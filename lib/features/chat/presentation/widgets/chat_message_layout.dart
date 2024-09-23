import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';

class MessageLayout extends StatelessWidget {
  final Color messageBgColor;
  final Alignment? alignment;
  final Timestamp createAt;
  final VoidCallback? onSwipe;
  final String message;
  final bool isShowTick;
  final bool isSeen;
  final VoidCallback? onLongPress;
  const MessageLayout(
      {super.key,
      required this.messageBgColor,
      required this.alignment,
      required this.createAt,
      required this.onSwipe,
      required this.message,
      required this.isShowTick,
      required this.isSeen,
      required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: SwipeTo(
          onRightSwipe: (details) {
            onSwipe;
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
                          padding: const EdgeInsets.only(
                              left: 10, right: 85, top: 3, bottom: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: messageBgColor),
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * .8),
                          child: Column(
                            children: [
                              Text(
                                message,
                                style: const TextStyle(
                                    fontSize: 18, color: whiteColor),
                              ),
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
