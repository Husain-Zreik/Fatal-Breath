// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:io';

import 'package:fatal_breath_frontend/tools/image.picker.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/widgets/button.global.dart';
import 'package:fatal_breath_frontend/widgets/profile.circle.dart';
import 'package:fatal_breath_frontend/widgets/secondary.appbar.dart';
import 'package:fatal_breath_frontend/widgets/text.form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String encodedImage = "";
  Uint8List? decoded;
  File? selectedImage;

  final _form = GlobalKey<FormState>();
  bool successful = true;
  String err = "";
  bool validated() {
    return _form.currentState!.validate();
  }

  Future inputImage() async {
    try {
      final imageInfo = await imagePicker();
      encodedImage = imageInfo["encoded"];

      setState(() {
        decoded = imageInfo["decoded"];
        selectedImage = imageInfo["selectedImage"];
      });
    } on HttpException catch (e) {
      print(e);
    }
  }

  Future updateProfile(name, username, email, encodedImage, context) async {
    try {
      setState(() {
        err = "";
      });

      if (!validated()) {
        successful = true;
        return err = "Fill the inputs correctly";
      }
      //Try signing up
      // await Provider.of<AuthProviders>(context, listen: false)
      //     .signUp(name, username, email, context);

      //Navigation
      Get.back();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SecondaryAppBar(title: "Edit Profile"),
      ),
      backgroundColor: GlobalColors.bgColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
            child: Column(
              children: [
                Stack(children: [
                  ProfileCircle(
                    size: 140,
                    image: selectedImage != null ? selectedImage! : null,
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          inputImage();
                        },
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 2, color: Colors.white),
                              color: GlobalColors.mainColor),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ))
                ]),
                Form(
                  key: _form,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      TextForm(
                        controller: nameController,
                        hintText: "name",
                        isPass: false,
                        label: 'Name',
                        validator: namevalidator,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextForm(
                        controller: usernameController,
                        hintText: "username",
                        isPass: false,
                        label: 'Username',
                        validator: usernamevalidator,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextForm(
                        controller: emailController,
                        hintText: "email",
                        isPass: false,
                        label: 'Email',
                        validator: emailvalidator,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ButtonGlobal(
                          text: 'Save',
                          bgColor: GlobalColors.mainColor,
                          textColor: Colors.white,
                          onBtnPressed: () {
                            setState(() {
                              successful = false;
                            });
                            updateProfile(
                                nameController.text,
                                usernameController.text,
                                emailController.text,
                                encodedImage,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
