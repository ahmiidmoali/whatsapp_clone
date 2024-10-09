import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';

class ChatTextfieldWidget extends StatelessWidget {
  final Function()? onClickAttached;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final void Function()? selectImage;
  final bool isReplaying;
  const ChatTextfieldWidget(
      {super.key,
      required this.onClickAttached,
      required this.controller,
      required this.onChanged,
      this.selectImage,
      required this.isReplaying});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(
          bottom: 5, left: 10, right: 5, top: isReplaying ? 0 : 5),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        style: const TextStyle(color: whiteColor),
        decoration: InputDecoration(
            filled: true,
            fillColor: appBarColor,
            hintText: "Message",
            hintStyle: const TextStyle(color: greyColor),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                  GestureDetector(
                    onTap: selectImage,
                    child: const Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: whiteColor,
                    ),
                  ),
                ],
              ),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: isReplaying == true
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25))
                    : BorderRadius.circular(25))),
      ),
    );
  }
}
