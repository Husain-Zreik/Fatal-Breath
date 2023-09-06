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
                text: 'Enter your Full Name',
                textInputType: TextInputType.emailAddress,
                obscure: false,
                label: 'Full Name',
              ),
              const SizedBox(
                height: 10,
              ),
              TextForm(
                controller: usernameController,
                text: 'Enter your Username',
                textInputType: TextInputType.emailAddress,
                obscure: false,
                label: 'Username',
              ),
              const SizedBox(
                height: 10,
              ),
              TextForm(
                controller: emailController,
                text: 'Email',
                textInputType: TextInputType.emailAddress,
                obscure: false,
                label: 'Email',
              ),
              const SizedBox(
                height: 10,
              ),
              TextForm(
                controller: passwordController,
                text: 'Password',
                textInputType: TextInputType.text,
                obscure: true,
                label: 'Password',
              ),
              const SizedBox(
                height: 10,
              ),
              TextForm(
                controller: verifypasswordController,
                text: 'Re-enter the Password',
                textInputType: TextInputType.text,
                obscure: true,
                label: 'Verify Password',
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
              const ButtonGlobal(text: 'Sign Un', color: '091479'),
              const SizedBox(
                height: 10,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       'Already have an Account?',
              //       style: GoogleFonts.poppins(
              //           color: Colors.black, fontWeight: FontWeight.w400),
              //     ),
              //     InkWell(
              //       child: Text(
              //         ' Sign In',
              //         style: GoogleFonts.poppins(color: HexColor('#0047FF')),
              //       ),
              //       onTap: () {
              //         Get.to(LoginScreen());
              //       },
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
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
                Get.to(LoginScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
