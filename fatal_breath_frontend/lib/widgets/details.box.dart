import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsBox extends StatelessWidget {
  const DetailsBox({Key? key, required this.label, required this.title})
      : super(key: key);

  final String label;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(7),
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
      child: Row(
        children: [
          Image.asset("assets/images/${label}_icon.png"),
          const SizedBox(
            width: 10,
          ),
          Text(title,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}
