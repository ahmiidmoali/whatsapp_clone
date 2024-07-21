import 'package:flutter/material.dart';
import 'package:whatsapp_clone/routes/on_generate_routes.dart';

import 'features/app/splash/splash_screen.dart';
import 'features/app/theme/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ).copyWith(
          scaffoldBackgroundColor: backgroundColor,
          dialogBackgroundColor: appBarColor,
          appBarTheme: const AppBarTheme(color: appBarColor)),
      initialRoute: "/",
      onGenerateRoute: OnGenerateRoute.route,
    );
  }
}
