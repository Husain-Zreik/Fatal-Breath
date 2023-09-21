import 'dart:io';

import 'package:fatal_breath_frontend/models/house.model.dart';
import 'package:fatal_breath_frontend/models/room.model.dart';
import 'package:fatal_breath_frontend/providers/house.provider.dart';
import 'package:fatal_breath_frontend/providers/room.provider.dart';
import 'package:fatal_breath_frontend/screens/main.screen.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/widgets/details.box.dart';
import 'package:fatal_breath_frontend/widgets/secondary.appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class RoomDetailsScreen extends StatefulWidget {
  const RoomDetailsScreen(
      {super.key,
      required this.room,
      required this.house,
      required this.userType});

  final House house;
  final Room room;
  final String userType;

  @override
  State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  late int percent = 0;
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

  Future deletePressed(roomId, context) async {
    await Provider.of<HouseProvider>(context, listen: false)
        .deleteRoom(roomId, context);
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
    if (widget.room.sensor != null) {
      percent = widget.room.sensor!.coLevel;
    }
  }

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
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
            child: Column(
              children: [
                CircularPercentIndicator(
                  radius: 100,
                  lineWidth: 12.0,
                  animation: true,
                  animationDuration: 1000,
                  curve: Curves.linear,
                  animateFromLastPercent: true,
                  percent: percent / 100,
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
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text("$percent%",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: percent < 30
                                      ? Colors.green
                                      : percent < 70
                                          ? const Color.fromARGB(
                                              255, 248, 116, 0)
                                          : Colors.red,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                          Text(
                            "Carbon\nMonoxide",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DetailsBox(
                          title: "${weatherData["temp"]}°C",
                          label: 'temperature'),
                      DetailsBox(
                          title: "${weatherData["wind"]}m/s", label: 'wind'),
                      DetailsBox(
                          title: "${weatherData["humidity"]}%",
                          label: 'humidity'),
                    ],
                  ),
                ),
                if (widget.userType == "Manager")
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm Delete'),
                            content: const Text(
                                'Are you sure you want to delete this house?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () async {
                                  await deletePressed(widget.room.id, context);
                                  Get.to(() => const MainScreen());
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 60,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text("Delete Room",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
