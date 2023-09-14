// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fatal_breath_frontend/screens/ai.screen.dart';
import 'package:fatal_breath_frontend/screens/chats.screen.dart';
import 'package:fatal_breath_frontend/screens/home.screen.dart';
import 'package:fatal_breath_frontend/screens/settings.screen.dart';
import 'package:fatal_breath_frontend/screens/users.screen.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/fontelico_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedindex = 0;

  List pages = [
    HomeScreen(),
    ChatsScreen(),
    UsersScreen(),
    AiScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedindex == 0 || _selectedindex == 2
          ? null
          : AppBar(
              backgroundColor: GlobalColors.bgColor,
              elevation: 0,
              centerTitle: true,
              leadingWidth: 65,
              // flexibleSpace: _selectedindex == 4
              //     ? null
              //     : Container(
              //         margin: EdgeInsets.fromLTRB(280, 43, 0, 0),
              //         // color: GlobalColors.mainColor,
              //         child: Icon(
              //           Icons.account_circle,
              //           size: 55,
              //         )),
              toolbarHeight: 80,
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image.asset(
                  'assets/images/light_icon.png',
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _selectedindex == 0
                      ? "Home"
                      : _selectedindex == 1
                          ? "Chats"
                          : _selectedindex == 2
                              ? "Members"
                              : _selectedindex == 3
                                  ? "Breathy"
                                  : "Settings",
                  style: GoogleFonts.poppins(
                    color: GlobalColors.mainColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
      body: pages[_selectedindex],
      backgroundColor: GlobalColors.bgColor,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: GlobalColors.mainColor,
        fixedColor: GlobalColors.mainColor,
        selectedIconTheme: IconThemeData(color: Colors.black),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedindex,
        onTap: (int index) {
          setState(() {
            _selectedindex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: _selectedindex == 0
                  ? Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 30,
                    )
                  : SvgPicture.asset(
                      "assets/images/home_icon.svg",
                      height: 30,
                      width: 30,
                      // ignore: deprecated_member_use
                      color: Colors.white,
                    ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                _selectedindex == 1 ? Icons.chat : Icons.chat_outlined,
                color: Colors.white,
                size: 27,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                _selectedindex == 2
                    ? Icons.add_circle
                    : Icons.add_circle_outline,
                color: Colors.white,
                size: 30,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                _selectedindex == 3
                    ? Fontelico.emo_thumbsup
                    : Fontelico.emo_happy,
                size: 22,
                color: Colors.white,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                _selectedindex == 4 ? Icons.settings : Icons.settings_outlined,
                color: Colors.white,
                size: 30,
              ),
              label: ''),
        ],
      ),
    );
  }
}
