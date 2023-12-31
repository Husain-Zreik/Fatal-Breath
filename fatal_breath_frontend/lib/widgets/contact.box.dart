import 'package:fatal_breath_frontend/config/remote.config.dart';
import 'package:fatal_breath_frontend/models/user.model.dart';
import 'package:fatal_breath_frontend/widgets/profile.circle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactBox extends StatelessWidget {
  const ContactBox({Key? key, this.child, required this.user, this.houseName})
      : super(key: key);

  final User user;
  final String? houseName;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                    width: 60,
                    child: ProfileCircle(
                      size: 60,
                      imageLink: user.profileImage != null
                          ? '$baseUrl/storage/profile_images/${user.id}.png'
                          : null,
                    )),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(houseName != null ? houseName! : user.username,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(houseName != null ? user.username : user.name,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ))
                    ],
                  ),
                ),
              ],
            ),
            if (child != null) child!
          ],
        ),
      ),
    );
  }
}
