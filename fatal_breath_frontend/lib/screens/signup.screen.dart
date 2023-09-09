// ignore_for_file: avoid_print

import 'dart:io';

import 'package:fatal_breath_frontend/providers/auth.provider.dart';
import 'package:fatal_breath_frontend/screens/home.screen.dart';
import 'package:fatal_breath_frontend/screens/login.screen.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/widgets/button.global.dart';
import 'package:fatal_breath_frontend/widgets/text.form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController verifypassController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final _form = GlobalKey<FormState>();
  bool successful = true;
  String groupValue = '1';
  String err = "";
  bool validated() {
    return _form.currentState!.validate();
  }

  Future signupPressed(name, username, email, password, role, context) async {
    try {
      setState(() {
        err = "";
      });

      if (!validated()) {
        successful = true;
        return err = "Fill the inputs correctly";
      }
      //Try signing up
      await Provider.of<AuthProviders>(context, listen: false)
          .signUp(name, username, email, password, role, context);

      //Navigation
      Get.to(() => const HomeScreen());
    } on HttpException catch (error) {
      setState(() {
        err = error.message;
        successful = true;
      });
    }
  }

  namevalidator(value) {
    if (value!.isEmpty) {
      return "Please enter the name";
    }
    if (!value.contains(" ")) {
      return "Please enter your full name";
    }
    return null;
  }

  usernamevalidator(value) {
    if (value!.isEmpty) {
      return "Please enter the name";
    }
    return null;
  }

  emailvalidator(value) {
    if (value!.isEmpty) {
      return "Please enter the email";
    }
    if (!value.contains("@")) {
      return "Please enter a valid email";
    }
    return null;
  }

  passwordvalidator(value) {
    if (value!.isEmpty) {
      return "Please enter password";
    }
    if (value.length < 6) {
      return "Should be minimum 6 characters";
    }
    return null;
  }

  verifypasswordvalidator(value) {
    if (value!.isEmpty) {
      return "Please re-enter your password";
    }
    if (value != passwordController.text) {
      return "Passwords doesn't match";
    }
    return null;
  }

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
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/images/light_icon.png',
                scale: 8,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'FATAL',
                    style: TextStyle(
                      color: GlobalColors.textColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'BREATH',
                    style: TextStyle(
                      color: HexColor('#1424B9'),
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              successful
                  ? Form(
                      key: _form,
                      child: Column(
                        children: [
                          TextForm(
                            controller: nameController,
                            hintText: 'Enter your Full Name',
                            textInputType: TextInputType.emailAddress,
                            isPass: false,
                            label: 'Full Name',
                            validator: namevalidator,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextForm(
                            controller: usernameController,
                            hintText: 'Enter your Username',
                            textInputType: TextInputType.emailAddress,
                            isPass: false,
                            label: 'Username',
                            validator: usernamevalidator,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextForm(
                            controller: emailController,
                            hintText: 'Enter your Email',
                            textInputType: TextInputType.emailAddress,
                            isPass: false,
                            label: 'Email',
                            validator: emailvalidator,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextForm(
                            controller: passwordController,
                            hintText: 'Enter your Password',
                            textInputType: TextInputType.text,
                            isPass: true,
                            label: 'Password',
                            validator: passwordvalidator,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextForm(
                            textInputType: TextInputType.text,
                            controller: verifypassController,
                            label: 'Verify Password',
                            hintText: 'Re-enter the Password',
                            isPass: true,
                            validator: verifypasswordvalidator,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              children: [
                                Text(
                                  'Type :',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      Radio(
                                          value: '1',
                                          groupValue: groupValue,
                                          onChanged: (value) {
                                            setState(() {
                                              groupValue = value!;
                                            });
                                          }),
                                      Text(
                                        'User',
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Radio(
                                          value: '0',
                                          groupValue: groupValue,
                                          onChanged: (value) {
                                            setState(() {
                                              groupValue = value!;
                                            });
                                          }),
                                      Text(
                                        'Admin',
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
              const SizedBox(
                height: 30,
              ),
              ButtonGlobal(
                  text: 'Sign Up',
                  color: '091479',
                  onBtnPressed: () {
                    setState(() {
                      successful = false;
                    });
                    signupPressed(
                        nameController.text,
                        usernameController.text,
                        emailController.text,
                        passwordController.text,
                        groupValue,
                        context);
                  }),
              const SizedBox(
                height: 30,
              ),
              Text(
                err,
                style: GoogleFonts.poppins(
                  color: GlobalColors.errColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        )),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an Account?',
              style: GoogleFonts.poppins(
                  color: Colors.black, fontWeight: FontWeight.w400),
            ),
            InkWell(
              child: Text(
                ' Sign In',
                style: GoogleFonts.poppins(color: HexColor('#0047FF')),
              ),
              onTap: () {
                Get.to(() => const LoginScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
