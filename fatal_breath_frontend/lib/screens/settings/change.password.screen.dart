import 'dart:io';

import 'package:fatal_breath_frontend/providers/auth.provider.dart';
import 'package:fatal_breath_frontend/providers/user.provider.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/widgets/button.global.dart';
import 'package:fatal_breath_frontend/widgets/secondary.appbar.dart';
import 'package:fatal_breath_frontend/widgets/text.form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController verifypassController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController oldpasswordController = TextEditingController();
  final _form = GlobalKey<FormState>();

  String err = "";
  bool validated() {
    return _form.currentState!.validate();
  }

  Future updatePassword(currentPassword, newPassword, context) async {
    try {
      setState(() {
        err = "";
      });

      if (!validated()) {
        return err = "Fill the inputs correctly";
      }

      await Provider.of<UserProvider>(context, listen: false)
          .changePassword(currentPassword, newPassword, context);

      Provider.of<AuthProvider>(context, listen: false)
          .updatePassword(newPassword);

      //Navigation
      Get.back();
    } on HttpException catch (error) {
      setState(() {
        err = error.message;
      });
    }
  }

  oldpasswordvalidator(value) {
    final oldPassword =
        Provider.of<AuthProvider>(context, listen: false).getPassword;

    if (value!.isEmpty) {
      return "Please enter the old password";
    } else if (value != oldPassword) {
      return "Doesn't match the old password";
    }
    return null;
  }

  passwordvalidator(value) {
    if (value!.isEmpty) {
      return "Please enter password";
    } else if (value.length < 6) {
      return "Should be minimum 6 characters";
    } else if (value == oldpasswordController.text) {
      return "Password in use ";
    }
    return null;
  }

  verifypasswordvalidator(value) {
    if (value!.isEmpty) {
      return "Please re-enter your password";
    } else if (value != passwordController.text) {
      return "Passwords doesn't match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SecondaryAppBar(title: "Change Password"),
      ),
      backgroundColor: GlobalColors.bgColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  TextForm(
                    textInputType: TextInputType.text,
                    controller: oldpasswordController,
                    label: 'Old Password',
                    hintText: 'Enter old Password',
                    isPass: true,
                    validator: oldpasswordvalidator,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextForm(
                    controller: passwordController,
                    hintText: 'Enter new Password',
                    textInputType: TextInputType.text,
                    isPass: true,
                    label: 'New Password',
                    validator: passwordvalidator,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextForm(
                    textInputType: TextInputType.text,
                    controller: verifypassController,
                    label: 'Verify Password',
                    hintText: 'Re-enter the Password',
                    isPass: true,
                    validator: verifypasswordvalidator,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ButtonGlobal(
                      text: 'Save',
                      bgColor: GlobalColors.mainColor,
                      textColor: Colors.white,
                      onBtnPressed: () {
                        updatePassword(oldpasswordController.text,
                            passwordController.text, context);
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
            ),
          ),
        ),
      ),
    );
  }
}
