import 'package:flutter/material.dart';
import "package:fluttertoast/fluttertoast.dart";

import 'package:whatsapp_clone/features/app/theme/style.dart';

void toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: backgroundColor,
      textColor: whiteColor,
      fontSize: 16);
}

// Future<GiphyGif?> pickGIF(BuildContext context) async {
//   try {
//     final gif = await GiphyPicker.pickGif(
//         context: context, apiKey: 'p3BG59fGyd2JEwFeTYPIByRaLiYKat7e');
//     return gif;
//   } catch (error) {
//     // Handle error appropriately (e.g., show a user-friendly message)
//     print('Error picking GIF: $error');
//     return null; // Indicate error by returning null
//   }
// }
