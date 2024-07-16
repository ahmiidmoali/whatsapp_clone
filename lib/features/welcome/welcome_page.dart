import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';
import 'package:whatsapp_clone/features/user/presentation/pages/login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "Welcome to Whatsapp Clone",
              style: TextStyle(
                  color: tabColor, fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Image.asset(
              "assets/bg_image.png",
            ),
            Column(
              children: [
                const Text(
                  "Read our Privacy Policy Tap, 'Agree and Continue' to accept the Team of Service.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Container(
                    color: messageColor,
                    padding: const EdgeInsets.all(5),
                    height: 35,
                    child: const Text(
                      "Agree And Continue",
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
