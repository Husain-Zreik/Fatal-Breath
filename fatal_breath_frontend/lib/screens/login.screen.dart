import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Image.asset(
                'assets/light_icon.png',
                scale: 1.5,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'FATAL BREATH',
                style: TextStyle(
                  color: GlobalColors.textColor,
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
