import 'package:fatal_breath_frontend/providers/auth.provider.dart';
import 'package:fatal_breath_frontend/providers/user.provider.dart';
import 'package:fatal_breath_frontend/screens/register/login.screen.dart';
import 'package:fatal_breath_frontend/screens/settings/change.password.screen.dart';
import 'package:fatal_breath_frontend/screens/settings/edit.profile.screen.dart';
import 'package:fatal_breath_frontend/widgets/button.global.dart';
import 'package:fatal_breath_frontend/widgets/profile.circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String? image;

  @override
  void initState() {
    super.initState();
    image = Provider.of<UserProvider>(context, listen: false).getImage;
  }

  void signUserout() {
    Provider.of<AuthProvider>(context, listen: false).logout();
    Get.off(() => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) => SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: Column(
              children: [
                ProfileCircle(
                  size: 140,
                  imageLink: context.watch<UserProvider>().getImage == 'null'
                      ? null
                      : context.watch<UserProvider>().getImage,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  value.username!,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  value.email!,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
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
