import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextError extends StatelessWidget {
  const TextError({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: GlobalColors.errColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
