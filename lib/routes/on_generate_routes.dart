import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/const/page_const.dart';
import 'package:whatsapp_clone/features/app/home/contact_page.dart';
import 'package:whatsapp_clone/features/app/welcome/welcome_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;
    final name = settings.name;
    switch (name) {
      case PageConst.welcomePage:
        {
          return materialPageBuilder(const WelcomePage());
        }
      case PageConst.contactUsersPage:
        {
          return materialPageBuilder(const ContactPage());
        }
    }
  }
}

dynamic materialPageBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
