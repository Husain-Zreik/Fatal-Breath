import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextForm extends StatelessWidget {
  const TextForm(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.textInputType,
      required this.isPass,
      required this.label,
      required this.validator})
      : super(key: key);

  final TextEditingController controller;
  final TextInputType? textInputType;
  final Function validator;
  final String hintText;
  final String label;
  final bool isPass;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          height: 50,
          padding: const EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 7,
                ),
              ]),
          child: TextFormField(
            controller: controller,
            keyboardType: textInputType,
            obscureText: isPass,
            decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(0),
                hintStyle: const TextStyle(
                  height: 1,
                  fontSize: 14,
                )),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return validator(value);
            },
          ),
        ),
      ],
    );
  }
}
