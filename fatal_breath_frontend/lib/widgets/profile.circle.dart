import 'package:flutter/material.dart';

class ProfileCircle extends StatefulWidget {
  const ProfileCircle({Key? key, required this.size, this.image})
      : super(key: key);

  final double size;
  final Widget? image;

  @override
  State<ProfileCircle> createState() => _ProfileCircleState();
}

class _ProfileCircleState extends State<ProfileCircle> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
          width: widget.size,
          height: widget.size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child:
              // value?.image != null && value.image.isNotEmpty
              //     ? Image.memory(
              //         base64Decode(value.image),
              //         fit: BoxFit.cover,
              //         width: widget.size,
              //         height: widget.size,
              //       ):
              widget.image ??
                  Image.asset(
                    "assets/images/account_circle.png",
                    fit: BoxFit.cover,
                    width: widget.size,
                    height: widget.size,
                  )),
    );
  }
}
