import 'dart:io';

import 'package:fatal_breath_frontend/models/house.model.dart';
import 'package:fatal_breath_frontend/models/room.model.dart';
import 'package:fatal_breath_frontend/providers/room.provider.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/widgets/secondary.appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class RoomDetailsScreen extends StatefulWidget {
  const RoomDetailsScreen({super.key, required this.room, required this.house});

  final House house;
  final Room room;

  @override
  State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  final int percent = 50;
  late Map weatherData = {};

  Future<void> fetchWeather() async {
    try {
      final data = await Provider.of<RoomProvider>(context, listen: false)
          .fetchWeather(widget.house.city, widget.house.country);
      setState(() {
        weatherData = data;
      });
    } catch (e) {
      throw HttpException('Error fetching weather data:$e');
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchWeather();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: SecondaryAppBar(title: widget.room.name),
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
                                fontSize: 16,
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
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
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
                            Image.asset("assets/images/temperature_icon.png"),
                            const SizedBox(
                              width: 5,
                            ),
                            Text("${weatherData["temp"]}°C",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
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
                            Image.asset("assets/images/wind_icon.png"),
                            const SizedBox(
                              width: 5,
                            ),
                            Text("${weatherData["wind"]}m/s",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
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
                            Image.asset("assets/images/humidity_icon.png"),
                            const SizedBox(
                              width: 5,
                            ),
                            Text("${weatherData["humidity"]}%",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
