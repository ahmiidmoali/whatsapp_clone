import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';

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
        actions: const [
          Icon(Icons.camera_alt_outlined),
          SizedBox(
            width: 20,
          ),
          Icon(Icons.search_outlined)
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
        children: const [
          Center(
            child: Text(
              "chats",
              style: TextStyle(color: whiteColor),
            ),
          ),
          Center(
            child: Text(
              "status",
              style: TextStyle(color: whiteColor),
            ),
          ),
          Center(
            child: Text(
              "calls",
              style: TextStyle(color: whiteColor),
            ),
          )
        ],
      ),
    );
  }

  switchfloatingActionButtonOnTabIndex(int index) {
    switch (index) {
      case 0:
        {
          return FloatingActionButton(
            backgroundColor: tabColor,
            onPressed: () {},
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
