import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/widgets/button.global.dart';
import 'package:fatal_breath_frontend/widgets/text.form.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                'assets/images/light_icon.png',
                scale: 6,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'FATAL ',
                      style: TextStyle(
                        color: GlobalColors.textColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'BREATH',
                      style: TextStyle(
                        color: HexColor('#1424B9'),
                        fontSize: 40,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextForm(
                controller: emailController,
                text: 'Email',
                textInputType: TextInputType.emailAddress,
                obscure: false,
                label: 'Email',
              ),
              const SizedBox(
                height: 40,
              ),
              TextForm(
                controller: passwordController,
                text: 'Password',
                textInputType: TextInputType.text,
                obscure: true,
                label: 'Password',
              ),
              const SizedBox(
                height: 50,
              ),
              const ButtonGlobal(),
            ],
          ),
        )),
      ),
    );
  }
}
