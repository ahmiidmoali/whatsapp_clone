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
