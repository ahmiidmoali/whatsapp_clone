import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/global/data/date_formats.dart';
import 'package:whatsapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';

class CallHistoryPage extends StatelessWidget {
  const CallHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: const Text(
              "Recent",
              style: TextStyle(
                  color: greyColor, fontSize: 14, fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) => ListTile(
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
              subtitle: Row(
                children: [
                  const Icon(
                    Icons.call_made,
                    color: Colors.green,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    formatDateTime(DateTime.now()),
                    style: const TextStyle(
                        color: greyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              trailing: const Icon(
                Icons.call,
                color: Colors.green,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
