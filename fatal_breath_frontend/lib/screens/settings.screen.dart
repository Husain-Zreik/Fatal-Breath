// ignore_for_file: avoid_print

import 'dart:io';

import 'package:fatal_breath_frontend/providers/auth.provider.dart';
import 'package:fatal_breath_frontend/screens/login.screen.dart';
import 'package:fatal_breath_frontend/screens/settings/change.password.screen.dart';
import 'package:fatal_breath_frontend/screens/settings/edit.profile.screen.dart';
import 'package:fatal_breath_frontend/widgets/button.global.dart';
import 'package:fatal_breath_frontend/widgets/profile.circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print("Failed to pick image : $e");
    }
  }

  void signUserout() {
    Provider.of<AuthProviders>(context, listen: false).logout();
    Get.to(() => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, value, child) => SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
            child: Column(
              children: [
                const ProfileCircle(size: 140),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  // value.name,
                  "username",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  // value.email,
                  "email",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),
                ButtonGlobal(
                  onBtnPressed: () {
                    Get.to(() => const EditProfileScreen());
                  },
                  textColor: Colors.black,
                  bgColor: Colors.white,
                  text: "ُEdit Profile",
                  icon: Icons.edit,
                ),
                const SizedBox(height: 30),
                ButtonGlobal(
                  onBtnPressed: () {
                    Get.to(() => const ChangePasswordScreen());
                  },
                  textColor: Colors.black,
                  bgColor: Colors.white,
                  text: "Change Password",
                  icon: Icons.lock,
                ),
                const SizedBox(height: 30),
                ButtonGlobal(
                  onBtnPressed: signUserout,
                  textColor: Colors.black,
                  bgColor: Colors.white,
                  text: "Log Out",
                  icon: Icons.logout,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
