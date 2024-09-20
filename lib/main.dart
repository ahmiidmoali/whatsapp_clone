import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/features/app/home/home_page.dart';
import 'package:whatsapp_clone/features/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:whatsapp_clone/features/chat/presentation/cubit/message/message_cubit.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/auth/cubit/auth_cubit.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/credential/cubit/credential_cubit.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/get_device_number/cubit/get_device_number_cubit.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/get_single_user/cubit/get_single_user_cubit.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/user/cubit/user_cubit.dart';
import 'package:whatsapp_clone/firebase_options.dart';
import 'package:whatsapp_clone/routes/on_generate_routes.dart';

import 'features/app/splash/splash_screen.dart';
import 'features/app/theme/style.dart';
import 'main_injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider(
          create: (context) => di.sl<CredentialCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<GetDeviceNumberCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<GetSingleUserCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<UserCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<ChatCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<MessageCubit>(),
        )
      ],
      child: MaterialApp(
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
        routes: {
          "/": (BuildContext context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is Authenticated) {
                  return HomePage(uid: state.uid);
                } else {
                  return const SplashScreen();
                }
              },
            );
          }
        },
      ),
    );
  }
}
