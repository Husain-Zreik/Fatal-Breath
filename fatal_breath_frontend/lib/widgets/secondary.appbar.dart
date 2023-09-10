// ignore_for_file: prefer_const_constructors

import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondaryAppBar extends StatefulWidget {
  const SecondaryAppBar({Key? key, required this.title, this.isProfile})
      : super(key: key);

  final String title;
  final bool? isProfile;

  @override
  State<SecondaryAppBar> createState() => _SecondaryAppBarState();
}

class _SecondaryAppBarState extends State<SecondaryAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: GlobalColors.mainColor,
      elevation: 0,
      centerTitle: true,
      leadingWidth: 50,
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back,
          size: 26,
        ),
      ),
      toolbarHeight: 80,
      title: Text(
        widget.title,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      actions: widget.isProfile == true
          ? [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child:
                          // value?.image != null && value.image.isNotEmpty
                          //     ? Image.memory(
                          //         base64Decode(value.image),
                          //         fit: BoxFit.cover,
                          //         width: 120,
                          //         height: 120,
                          //       ):
                          Image.asset("assets/images/account_circle.png")),
                ),
              ),
            ]
          : null,
    );
  }
}