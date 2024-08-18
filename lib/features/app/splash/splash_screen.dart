import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';
import 'package:whatsapp_clone/features/app/welcome/welcome_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomePage(),
            ),
            (route) => false,
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Image.asset(
            "assets/whats_app_logo.png",
            color: whiteColor,
            height: 100,
            width: 100,
          ),
          Column(
            children: [
              const Text(
                "from",
                style: TextStyle(
                    color: whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/meta.png",
                    color: whiteColor,
                    height: 35,
                    width: 35,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Meta",
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
