import 'dart:async';

import 'package:fatal_breath_frontend/screens/login.screen.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Get.to(LoginScreen());
    });
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
