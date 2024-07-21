import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/const/page_const.dart';
import 'package:whatsapp_clone/features/app/home/contact_page.dart';
import 'package:whatsapp_clone/features/app/settings/settings_page.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';
import 'package:whatsapp_clone/features/call/presentation/pages/call_history_page.dart';
import 'package:whatsapp_clone/features/chat/presentation/pages/chat_page.dart';
import 'package:whatsapp_clone/features/status/presentation/pages/status_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  TabController? _tabController;
  int _currentTabIndex = 0;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController!.addListener(
      () {
        setState(() {
          _currentTabIndex = _tabController!.index;
        });
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "WhatsApp",
          style: TextStyle(color: greyColor),
        ),
        actions: [
          const Icon(Icons.camera_alt_outlined, color: greyColor),
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.search_outlined,
            color: greyColor,
          ),
          const SizedBox(
            width: 10,
          ),
          PopupMenuButton(
            color: appBarColor,
            icon: const Icon(Icons.more_vert, color: greyColor),
            onSelected: (value) {},
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              PopupMenuItem(
                  value: "Settings",
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ));
                    },
                    child: const Text(
                      "Settings",
                      style: TextStyle(color: whiteColor),
                    ),
                  ))
            ],
          ),
        ],
        bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            controller: _tabController,
            labelColor: tabColor,
            unselectedLabelColor: greyColor,
            indicatorColor: tabColor,
            tabs: const [
              Tab(
                child: Text(
                  "Chats",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              Tab(
                child: Text(
                  "Status",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              Tab(
                child: Text(
                  "Calls",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              )
            ]),
      ),
      floatingActionButton:
          switchfloatingActionButtonOnTabIndex(_currentTabIndex),
      body: TabBarView(
        controller: _tabController,
        children: const [ChatPage(), StatusPage(), CallHistoryPage()],
      ),
    );
  }

  switchfloatingActionButtonOnTabIndex(int index) {
    switch (index) {
      case 0:
        {
          return FloatingActionButton(
            backgroundColor: tabColor,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ContactPage(),
              ));
            },
            child: const Icon(Icons.message_rounded),
          );
        }
      case 1:
        {
          return FloatingActionButton(
            backgroundColor: tabColor,
            onPressed: () {},
            child: const Icon(Icons.camera_alt_outlined),
          );
        }
      case 2:
        {
          return FloatingActionButton(
            backgroundColor: tabColor,
            onPressed: () {},
            child: const Icon(Icons.call_outlined),
          );
        }
    }
  }
}
