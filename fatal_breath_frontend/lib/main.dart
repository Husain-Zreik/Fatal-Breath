import 'package:fatal_breath_frontend/providers/auth.provider.dart';
import 'package:fatal_breath_frontend/providers/user.provider.dart';
import 'package:fatal_breath_frontend/screens/login.screen.dart';
import 'package:fatal_breath_frontend/screens/signup.screen.dart';
import 'package:fatal_breath_frontend/screens/splash.screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider<Auth>(
        //   create: (context) => Auth(),
        // ),
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider<User>(
          create: (context) => User(),
        ),
      ],
      child: const MyApp(), // Your MaterialApp widget
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/signup', page: () => const SignUpScreen()),
      ],
    );
  }
}
