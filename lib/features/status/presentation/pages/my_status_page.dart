import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/global/data/date_formats.dart';
import 'package:whatsapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';

class MyStatusPage extends StatelessWidget {
  const MyStatusPage({super.key});

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
        title: Text(
          "My Status",
          style: TextStyle(
              color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: profileWidget(),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    formatDateTime(DateTime.now()),
                    style: const TextStyle(
                        color: greyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                PopupMenuButton(
                  color: appBarColor,
                  icon: const Icon(Icons.more_vert, color: greyColor),
                  onSelected: (value) {},
                  itemBuilder: (context) => <PopupMenuEntry<String>>[
                    PopupMenuItem(
                        value: "Delete",
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => const SettingsPage(),
                            // ));
                          },
                          child: const Text(
                            "Delete",
                            style: TextStyle(color: whiteColor),
                          ),
                        ))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
