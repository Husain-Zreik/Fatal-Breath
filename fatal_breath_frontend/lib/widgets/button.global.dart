import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ButtonGlobal extends StatelessWidget {
  const ButtonGlobal(
      {Key? key,
      required this.text,
      required this.color,
      required this.onBtnPressed})
      : super(key: key);

  final String text;
  final String color;
  final Function onBtnPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onBtnPressed();
      },
      child: Container(
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
            color: HexColor('#$color'),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              ),
            ]),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
