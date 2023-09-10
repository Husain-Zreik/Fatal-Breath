import 'package:fatal_breath_frontend/providers/auth.provider.dart';
import 'package:fatal_breath_frontend/providers/user.provider.dart';
import 'package:fatal_breath_frontend/screens/home.screen.dart';
import 'package:fatal_breath_frontend/screens/login.screen.dart';
import 'package:fatal_breath_frontend/screens/main.screen.dart';
import 'package:fatal_breath_frontend/screens/signup.screen.dart';
import 'package:fatal_breath_frontend/screens/splash.screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProviders>(
          create: (context) => AuthProviders(),
        ),
        ChangeNotifierProvider.value(
          value: AuthProviders(),
        ),
        ChangeNotifierProvider<User>(
          create: (context) => User(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/main',
        routes: {
          "/splash": (context) => const SplashScreen(),
          "/login": (context) => const LoginScreen(),
          "/signup": (context) => const SignUpScreen(),
        },
        getPages: [
          GetPage(name: '/splash', page: () => const SplashScreen()),
          GetPage(name: '/login', page: () => const LoginScreen()),
          GetPage(name: '/signup', page: () => const SignUpScreen()),
          GetPage(name: '/main', page: () => const MainScreen()),
          GetPage(name: '/home', page: () => const HomeScreen()),
        ],
      ),
    );
  }
}
