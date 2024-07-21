import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/global/data/date_formats.dart';
import 'package:whatsapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';
import 'package:whatsapp_clone/features/status/presentation/pages/my_status_page.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        ListTile(
          leading: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                border: Border.all(width: 3)),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: profileWidget(),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: tabColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: backgroundColor)),
                      child: const Icon(
                        Icons.add,
                        color: whiteColor,
                        size: 15,
                      ),
                    ))
              ],
            ),
          ),
          title: const Text(
            "My status",
            style: TextStyle(
                color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          subtitle: const Text(
            "tap to add your status update",
            style: const TextStyle(
                color: greyColor, fontSize: 12, fontWeight: FontWeight.w500),
          ),
          trailing: InkWell(
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MyStatusPage(),
                  ));
                },
                icon: const Icon(
                  color: greyColor,
                  Icons.more_horiz,
                  size: 28,
                )),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 10),
          child: const Text(
            "Recent updates",
            style: TextStyle(
                color: greyColor, fontSize: 12, fontWeight: FontWeight.w500),
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
                  color: whiteColor, fontSize: 18, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              formatDateTime(DateTime.now()),
              style: const TextStyle(
                  color: greyColor, fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
    )));
  }
}
