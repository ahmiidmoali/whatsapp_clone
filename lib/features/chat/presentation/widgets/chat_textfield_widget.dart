import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';

class ChatTextfieldWidget extends StatelessWidget {
  final Function()? onClickAttached;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  const ChatTextfieldWidget(
      {super.key,
      required this.onClickAttached,
      required this.controller,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        style: const TextStyle(color: whiteColor),
        decoration: InputDecoration(
            filled: true,
            fillColor: senderMessageColor,
            hintText: "Message",
            hintStyle: const TextStyle(color: greyColor),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
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
                        onTap: onClickAttached,
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
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(40))),
      ),
    );
  }
}
