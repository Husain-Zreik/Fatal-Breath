import 'package:fatal_breath_frontend/providers/auth.provider.dart';
import 'package:fatal_breath_frontend/providers/house.provider.dart';
import 'package:fatal_breath_frontend/providers/room.provider.dart';
import 'package:fatal_breath_frontend/providers/user.provider.dart';
import 'package:fatal_breath_frontend/screens/empty/home.empty.state.screen.dart';
import 'package:fatal_breath_frontend/screens/home/home.screen.dart';
import 'package:fatal_breath_frontend/screens/register/login.screen.dart';
import 'package:fatal_breath_frontend/screens/main.screen.dart';
import 'package:fatal_breath_frontend/screens/register/signup.screen.dart';
import 'package:fatal_breath_frontend/screens/register/splash.screen.dart';
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
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        // ChangeNotifierProvider.value(
        //   value: AuthProvider(),
        // ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<HouseProvider>(
          create: (context) => HouseProvider(),
        ),
        ChangeNotifierProvider<RoomProvider>(
          create: (context) => RoomProvider(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          "/splash": (context) => const SplashScreen(),
          "/login": (context) => const LoginScreen(),
          "/signup": (context) => const SignUpScreen(),
          "/home_emptyState": (context) => const HomeEmptyStateScreen(),
        },
        getPages: [
          GetPage(name: '/splash', page: () => const SplashScreen()),
          GetPage(name: '/login', page: () => const LoginScreen()),
          GetPage(name: '/signup', page: () => const SignUpScreen()),
          GetPage(name: '/main', page: () => const MainScreen()),
          GetPage(name: '/home', page: () => const HomeScreen()),
          GetPage(
              name: '/home_emptyState',
              page: () => const HomeEmptyStateScreen()),
        ],
      ),
    );
  }
}
