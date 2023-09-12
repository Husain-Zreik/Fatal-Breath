import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonGlobal extends StatelessWidget {
  const ButtonGlobal({
    Key? key,
    this.text,
    required this.bgColor,
    required this.onBtnPressed,
    required this.textColor,
    this.icon,
  }) : super(key: key);

  final String? text;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;
  final Function onBtnPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onBtnPressed();
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              ),
            ]),
        child: icon == null && text == null
            ? null
            : Row(
                mainAxisAlignment: icon != null && text != null
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Icon(
                        icon,
                        color: textColor,
                        size: 26,
                      ),
                    ),
                  if (icon != null) const SizedBox(width: 15),
                  if (text != null)
                    Text(
                      text!,
                      style: GoogleFonts.poppins(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
