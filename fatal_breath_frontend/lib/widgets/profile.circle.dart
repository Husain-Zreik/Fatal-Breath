import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ProfileCircle extends StatelessWidget {
  const ProfileCircle(
      {Key? key, required this.size, this.image, this.decoded, this.imageLink})
      : super(key: key);

  final double size;
  final String? imageLink;
  final File? image;
  final Uint8List? decoded;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: decoded != null
              ? Image.memory(
                  decoded!,
                  fit: BoxFit.cover,
                  width: size,
                  height: size,
                )
              : image != null
                  ? Image.file(
                      image!,
                      fit: BoxFit.cover,
                      width: size,
                      height: size,
                    )
                  : imageLink != null
                      ? Image.network(
                          imageLink!,
                          fit: BoxFit.cover,
                          width: size,
                          height: size,
                        )
                      : Image.asset(
                          "assets/images/account_circle.png",
                          fit: BoxFit.cover,
                          width: size,
                          height: size,
                        )),
    );
  }
}
