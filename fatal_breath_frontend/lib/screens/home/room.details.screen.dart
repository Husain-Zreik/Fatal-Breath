import 'package:fatal_breath_frontend/models/room.model.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/widgets/secondary.appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class RoomDetailsScreen extends StatelessWidget {
  const RoomDetailsScreen({super.key, required this.room});

  final Room room;
  final int percent = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: SecondaryAppBar(title: room.name),
      ),
      backgroundColor: GlobalColors.bgColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
            child: Column(
              children: [
                CircularPercentIndicator(
                  radius: 100,
                  lineWidth: 12.0,
                  animation: true,
                  animationDuration: 1000,
                  curve: Curves.linear,
                  animateFromLastPercent: true,
                  percent: 0.9,
                  center: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: GlobalColors.mainColor,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("90%",
                              style: GoogleFonts.poppins(
                                color: percent < 30
                                    ? Colors.green
                                    : percent < 70
                                        ? const Color.fromARGB(255, 248, 116, 0)
                                        : Colors.red,
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                              )),
                          Text("Oxygen",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      ),
                    ),
                  ),
                  maskFilter: const MaskFilter.blur(BlurStyle.solid, 1),
                  progressColor: percent < 30
                      ? Colors.green
                      : percent < 70
                          ? const Color.fromARGB(255, 248, 116, 0)
                          : Colors.red,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
