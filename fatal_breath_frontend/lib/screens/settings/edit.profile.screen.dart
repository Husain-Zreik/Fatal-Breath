// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:io';

import 'package:fatal_breath_frontend/providers/user.provider.dart';
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
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController usernameController =
      TextEditingController(text: "");
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController nameController = TextEditingController(text: "");
  String currentImageLink = "null";

  String? encodedImage;
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
      if (imageInfo == null) {
        return null;
      }
      encodedImage = imageInfo["encoded"];

      setState(() {
        decoded = imageInfo["decoded"];
        selectedImage = imageInfo["selectedImage"];
      });
    } on HttpException catch (e) {
      print(e);
    }
  }

  Future saveProfile(name, username, email, profileImage, context) async {
    try {
      setState(() {
        err = "";
      });

      if (!validated()) {
        successful = true;
        return err = "Fill the inputs correctly";
      }
      //Try signing up
      await Provider.of<UserProvider>(context, listen: false).updateProfile(
        name,
        username,
        email,
        profileImage,
        context,
      );

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
  void initState() {
    super.initState();

    currentImageLink = context.read<UserProvider>().getImage!;
    debugPrint(currentImageLink);
    nameController.text = context.read<UserProvider>().getName!;
    usernameController.text = context.read<UserProvider>().getUsername!;
    emailController.text = context.read<UserProvider>().getEmail!;
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
                    decoded: decoded != null ? decoded! : null,
                    imageLink:
                        currentImageLink == 'null' ? null : currentImageLink,
                    // image: selectedImage != null ? selectedImage! : null,
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
                        hintText: context.watch<UserProvider>().getName!,
                        isPass: false,
                        label: 'Name',
                        validator: namevalidator,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextForm(
                        controller: usernameController,
                        hintText: context.watch<UserProvider>().getUsername!,
                        isPass: false,
                        label: 'Username',
                        validator: usernamevalidator,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextForm(
                        controller: emailController,
                        hintText: context.watch<UserProvider>().getEmail!,
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
                            saveProfile(
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
