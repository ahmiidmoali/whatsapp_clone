import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';
import 'package:whatsapp_clone/features/user/presentation/pages/inital_profile_submit_page.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late TextEditingController _pinCodeController;
  @override
  void initState() {
    _pinCodeController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  // @override
  // void dispose() {
  //   _pinCodeController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 10),
        child: Column(
          children: [
            const Text(
              "Verify your OTP",
              style: TextStyle(
                  color: tabColor, fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const Text(
              "WhatsApp Clone will send you SMS message (carrier charges may apply) to verify your phone number. Enter the country code and phone number",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: PinCodeFields(
                      textStyle: TextStyle(
                        color: whiteColor,
                      ),
                      controller: _pinCodeController,
                      onComplete: (value) {},
                      length: 6,
                    ),
                  ),
                  const Text(
                    "Enter your 6 digit code",
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InitialProfileSubmitPage(),
                  ),
                  (route) => false,
                );
              },
              child: Container(
                color: messageColor,
                padding: const EdgeInsets.all(5),
                height: 40,
                width: 120,
                child: const Text(
                  "Next",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
