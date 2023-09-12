import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextNote extends StatelessWidget {
  const TextNote({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ));
  }
}
