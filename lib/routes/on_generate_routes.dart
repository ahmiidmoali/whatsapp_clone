import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/const/page_const.dart';
import 'package:whatsapp_clone/features/app/home/contact_page.dart';
import 'package:whatsapp_clone/features/app/settings/settings_page.dart';
import 'package:whatsapp_clone/features/app/splash/splash_screen.dart';
import 'package:whatsapp_clone/features/user/domain/entities/user_entitiy.dart';
import 'package:whatsapp_clone/features/user/presentation/pages/edit_profile_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;
    final name = settings.name;
    switch (name) {
      case PageConst.welcomePage:
        {
          return materialPageBuilder(const SplashScreen());
        }
      case PageConst.contactUsersPage:
        {
          if (args is String) {
            return materialPageBuilder(ContactPage(
              uid: args,
            ));
          } else {
            return materialPageBuilder(const ErrorPage());
          }
        }

      case PageConst.settingsPage:
        {
          if (args is String) {
            return materialPageBuilder(SettingsPage(uid: args));
          } else {
            return materialPageBuilder(const ErrorPage());
          }
        }
      case PageConst.editProfilePage:
        {
          if (args is UserEntity) {
            return materialPageBuilder(EditProfilePage(singleUser: args));
          } else {
            return materialPageBuilder(const ErrorPage());
          }
        }
    }
    return materialPageBuilder(const ErrorPage());
  }
}

dynamic materialPageBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
      body: const Center(
        child: Text("Error"),
      ),
    );
  }
}
