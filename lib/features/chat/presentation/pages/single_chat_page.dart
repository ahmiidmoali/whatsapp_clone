import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';

class SingleChatPage extends StatefulWidget {
  const SingleChatPage({super.key});

  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  late TextEditingController messageController;
  bool _isVisible = false;
  @override
  void initState() {
    messageController = TextEditingController();
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
        title: const ListTile(
          title: Text(
            "Username",
            style: TextStyle(
                color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
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
      body: Stack(
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
                setState(() {
                  _isVisible = false;
                });
              }
            },
            child: Column(
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    MessageLayout(
                      messageBgColor: messageColor,
                      alignment: Alignment.centerRight,
                      createAt: Timestamp.now(),
                      onSwipe: () {},
                      message: 'hi',
                      isShowTick: true,
                      isSeen: true,
                      onLongPress: () {},
                    ),
                    MessageLayout(
                      messageBgColor: senderMessageColor,
                      alignment: Alignment.centerLeft,
                      createAt: Timestamp.now(),
                      onSwipe: () {},
                      message: 'hi bruh how do you do , where are you rn',
                      isShowTick: true,
                      isSeen: true,
                      onLongPress: () {},
                    )
                  ],
                )),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: TextField(
                    controller: messageController,
                    style: const TextStyle(color: whiteColor),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: senderMessageColor,
                        hintText: "Message",
                        hintStyle: const TextStyle(color: greyColor),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 15),
                        prefixIcon: const Icon(
                          Icons.emoji_emotions,
                          size: 20,
                          color: whiteColor,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Transform.rotate(
                                  angle: -.5,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isVisible = true;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.attach_file,
                                      size: 20,
                                      color: whiteColor,
                                    ),
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.camera_alt,
                                size: 20,
                                color: whiteColor,
                              ),
                            ],
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40))),
                  ),
                ),
              ],
            ),
          ),
          if (_isVisible)
            const Positioned(
                right: 1,
                top: 350,
                left: 50,
                bottom: 2,
                child: AttachedWidget())
        ],
      ),
    );
  }
}

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

class AttachedIcon extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Color color;
  final void Function()? onTap;
  const AttachedIcon(
      {super.key,
      required this.icon,
      required this.text,
      required this.color,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(50)),
              child: Icon(
                icon,
                size: 35,
                color: whiteColor,
              )),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: const TextStyle(color: greyColor),
          )
        ],
      ),
    );
  }
}

class AttachedWidget extends StatelessWidget {
  const AttachedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: const BoxDecoration(
            color: senderMessageColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AttachedIcon(
                  color: Color.fromARGB(255, 203, 57, 229),
                  icon: Icons.document_scanner,
                  text: "Document",
                ),
                AttachedIcon(
                  color: Color.fromARGB(255, 203, 40, 78),
                  icon: Icons.camera_alt_outlined,
                  text: "Camera",
                ),
                AttachedIcon(
                  color: Color.fromARGB(255, 243, 74, 130),
                  icon: Icons.image,
                  text: "Gallery",
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AttachedIcon(
                  color: Colors.orange,
                  icon: Icons.headphones,
                  text: "Audio",
                ),
                AttachedIcon(
                  color: Colors.green,
                  icon: Icons.location_on,
                  text: "Location",
                ),
                AttachedIcon(
                  color: Colors.purple,
                  icon: Icons.person_rounded,
                  text: "Contacts",
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AttachedIcon(
                  color: Color.fromARGB(255, 11, 146, 16),
                  icon: Icons.poll,
                  text: "Poll",
                ),
                AttachedIcon(
                  color: Color.fromARGB(255, 63, 104, 138),
                  icon: Icons.gif_box_outlined,
                  text: "Gift",
                ),
                AttachedIcon(
                  color: Color.fromARGB(255, 137, 219, 140),
                  icon: Icons.video_camera_back_rounded,
                  text: "Vedio",
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
