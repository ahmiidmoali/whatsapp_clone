import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Select Contants",
            style: TextStyle(
                color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: greyColor,
              )),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              // Navigator.of(context).
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
                    color: whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              subtitle: const Text(
                "hey there!i'm using whatsapp ",
                style: TextStyle(
                    color: greyColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ));
  }
}
