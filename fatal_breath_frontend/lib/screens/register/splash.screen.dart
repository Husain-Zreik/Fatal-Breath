import 'dart:async';

import 'package:fatal_breath_frontend/providers/auth.provider.dart';
import 'package:fatal_breath_frontend/providers/house.provider.dart';
import 'package:fatal_breath_frontend/providers/user.provider.dart';
import 'package:fatal_breath_frontend/screens/main.screen.dart';
import 'package:fatal_breath_frontend/screens/register/login.screen.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userType;

  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    final isValid = await loggedInChecker(context);

    Timer(const Duration(seconds: 3), () {
      isValid == true
          ? Get.off(() => const MainScreen())
          : Get.off(() => const LoginScreen());
    });
  }

  Future<bool> loggedInChecker(context) async {
    final isValid = await Provider.of<AuthProvider>(context, listen: false)
        .checkTokenValidity();
    if (isValid == true) {
      await Provider.of<UserProvider>(context, listen: false).getUser(context);
      userType = Provider.of<UserProvider>(context, listen: false).getUserType;

      if (userType == "Manager") {
        await Provider.of<HouseProvider>(context, listen: false)
            .getAdminHouses();
      } else {
        await Provider.of<HouseProvider>(context, listen: false)
            .getUserHouses();
      }
    }
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'FATAL ',
              style: TextStyle(
                color: Colors.grey[50],
                fontSize: 40,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              'BREATH',
              style: TextStyle(
                color: Colors.red[600],
                fontSize: 40,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
