import 'package:fatal_breath_frontend/providers/house.provider.dart';
import 'package:fatal_breath_frontend/providers/user.provider.dart';
import 'package:fatal_breath_frontend/screens/empty/home.empty.state.screen.dart';
import 'package:fatal_breath_frontend/screens/empty/house.empty.state.screen.dart';
import 'package:fatal_breath_frontend/screens/empty/user.empty.state.screen.dart';
import 'package:fatal_breath_frontend/screens/home/add.room.screen.dart';
import 'package:fatal_breath_frontend/screens/home/edit.houses.screen.dart';
import 'package:fatal_breath_frontend/screens/home/room.details.screen.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/widgets/add.box.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List? houses;
  String? name;
  String? userType;

  @override
  void initState() {
    super.initState();
    userType = Provider.of<UserProvider>(context, listen: false).getUserType;

    if (userType == "Manager") {
      Provider.of<HouseProvider>(context, listen: false).getAdminHouses();
    } else {
      Provider.of<HouseProvider>(context, listen: false).getUserHouses();
    }
    name = Provider.of<UserProvider>(context, listen: false).getName;
  }

  @override
  Widget build(BuildContext context) {
    houses = Provider.of<HouseProvider>(context).getHouses ?? [];
    return DefaultTabController(
      length: houses!.isEmpty ? 0 : houses!.length,
      child: Scaffold(
        backgroundColor: GlobalColors.bgColor,
        appBar: AppBar(
          backgroundColor: GlobalColors.bgColor,
          elevation: 0,
          centerTitle: true,
          leadingWidth: 65,
          toolbarHeight: 80,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image.asset(
              'assets/images/light_icon.png',
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'FATAL',
                      style: TextStyle(
                        color: GlobalColors.textColor,
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'BREATH',
                      style: TextStyle(
                        color: HexColor('#1424B9'),
                        fontSize: 26,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Welcome ",
                        style: GoogleFonts.poppins(
                          color: GlobalColors.mainColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        )),
                    Text("${name!} !",
                        style: GoogleFonts.poppins(
                          color: GlobalColors.mainColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ],
            ),
          ),
          actions: userType == "Manager"
              ? [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, right: 15),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => EditHousesScreen(houses: houses));
                      },
                      child: Icon(
                        FontAwesome.edit,
                        size: 32,
                        color: GlobalColors.mainColor,
                      ),
                    ),
                  )
                ]
              : null,
          bottom: houses!.isEmpty
              ? null
              : PreferredSize(
                  preferredSize: const Size.fromHeight(70),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: GlobalColors.mainColor,
                    ),
                    child: TabBar(
                      isScrollable: true,
                      indicator: null,
                      indicatorColor: Colors.transparent,
                      physics: const BouncingScrollPhysics(),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey[500],
                      tabs: [
                        for (final house in houses!)
                          Tab(
                            text: house.name,
                          ),
                      ],
                    ),
                  ),
                ),
        ),
        body: houses!.isEmpty
            ? userType == "Manager"
                ? const HomeEmptyStateScreen()
                : const UserEmptyStateScreen(
                    text: "You are not a member in any house",
                  )
            : TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  for (final house in houses!)
                    house.rooms != null && house.rooms!.isNotEmpty
                        ? SingleChildScrollView(
                            child: Padding(
                            padding: const EdgeInsets.only(bottom: 30, top: 10),
                            child: Column(children: [
                              if (userType == "Manager")
                                InkWell(
                                    onTap: () {
                                      Get.to(() =>
                                          AddRoomScreen(houseId: house.id));
                                    },
                                    child: const AddBox(label: "Add Room")),
                              for (final room in house.rooms!)
                                InkWell(
                                  onTap: room.hasSensor
                                      ? () {
                                          Get.to(() => RoomDetailsScreen(
                                                userType: userType!,
                                                room: room,
                                                house: house,
                                              ));
                                        }
                                      : null,
                                  child: Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(20, 5, 20, 0),
                                    height: 80,
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
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 60,
                                                child: Image.asset(
                                                  'assets/images/${room.type}.png',
                                                  scale: 1.2,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(room.name,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Colors.black,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        )),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                        "Carbon Monoxide : ${room.sensor == null ? "0" : room.sensor.coLevel}%",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: room.sensor ==
                                                                  null
                                                              ? Colors.grey
                                                              : room.sensor
                                                                          .coLevel <=
                                                                      30
                                                                  ? Colors.green
                                                                  : room.sensor
                                                                              .coLevel <=
                                                                          60
                                                                      ? Colors
                                                                          .orange
                                                                      : Colors
                                                                          .red,
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 25,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              color: room.sensor == null
                                                  ? Colors.grey
                                                  : room.sensor.coLevel <= 30
                                                      ? Colors.green
                                                      : room.sensor.coLevel <=
                                                              60
                                                          ? Colors.orange
                                                          : Colors.red,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: Text(
                                                  room.sensor == null
                                                      ? "No Sensor"
                                                      : room.sensor.coLevel <=
                                                              30
                                                          ? "Normal"
                                                          : room.sensor
                                                                      .coLevel <=
                                                                  60
                                                              ? "Sensitive"
                                                              : "Dangerous",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ]),
                          ))
                        : userType == "Manager"
                            ? HouseEmptyStateScreen(
                                houseId: house.id,
                              )
                            : const UserEmptyStateScreen(
                                text: "There are no rooms in this house",
                              ),
                ],
              ),
      ),
    );
  }
}
