import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';

class AttachedWidget extends StatelessWidget {
  final void Function()? selectVedio;
  final void Function()? selectGif;
  const AttachedWidget({super.key, this.selectVedio, this.selectGif});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: const BoxDecoration(
            color: senderMessageColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Row(
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
            const Row(
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
                const AttachedIcon(
                  color: Color.fromARGB(255, 11, 146, 16),
                  icon: Icons.poll,
                  text: "Poll",
                ),
                AttachedIcon(
                  onTap: selectGif,
                  color: const Color.fromARGB(255, 63, 104, 138),
                  icon: Icons.gif_box_outlined,
                  text: "Gift",
                ),
                AttachedIcon(
                  onTap: selectVedio,
                  color: const Color.fromARGB(255, 137, 219, 140),
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
