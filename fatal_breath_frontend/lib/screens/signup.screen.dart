import 'package:fatal_breath_frontend/screens/login.screen.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/widgets/button.global.dart';
import 'package:fatal_breath_frontend/widgets/text.form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController verifypasswordController =
      TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  String groupValue = '1';
  loginPressed() {
    // ignore: avoid_print
    print(emailController.text);
  }

  emailvalidator(value) {
    if (value!.isEmpty) {
      return "Please enter password";
    }
    if (value.length < 10) {
      return "Should be minimum 10 characters";
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
                height: 20,
              ),
              TextForm(
                controller: nameController,
                hintText: 'Enter your Full Name',
                textInputType: TextInputType.emailAddress,
                isPass: false,
                label: 'Full Name',
                validator: emailvalidator,
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
                validator: emailvalidator,
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
                validator: emailvalidator,
              ),
              const SizedBox(
                height: 10,
              ),
              TextForm(
                controller: verifypasswordController,
                hintText: 'Re-enter the Password',
                textInputType: TextInputType.text,
                isPass: true,
                label: 'Verify Password',
                validator: emailvalidator,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Text(
                      'Type :',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 20,
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
                              fontSize: 16,
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
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ButtonGlobal(
                text: 'Sign Un',
                color: '091479',
                onBtnPressed: () => loginPressed(),
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
                Get.to(const LoginScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
