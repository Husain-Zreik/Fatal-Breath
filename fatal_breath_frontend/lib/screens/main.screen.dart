import 'package:fatal_breath_frontend/providers/user.provider.dart';
import 'package:fatal_breath_frontend/screens/chats/chats.screen.dart';
import 'package:fatal_breath_frontend/screens/users-houses/find.house.screen.dart';
import 'package:fatal_breath_frontend/screens/home/home.screen.dart';
import 'package:fatal_breath_frontend/screens/settings/settings.screen.dart';
import 'package:fatal_breath_frontend/screens/users-houses/users.screen.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedindex = 0;
  String? userType;

  @override
  void initState() {
    super.initState();
    userType = Provider.of<UserProvider>(context, listen: false).getUserType;
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      const HomeScreen(),
      const ChatsScreen(),
      userType == "Manager" ? const UsersScreen() : const FindHouseScreen(),
      const SettingsScreen(),
    ];

    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar:
              _selectedindex == 0 || _selectedindex == 2 || _selectedindex == 1
                  ? null
                  : AppBar(
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
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Settings",
                          style: GoogleFonts.poppins(
                            color: GlobalColors.mainColor,
                            fontSize: 24,
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
            selectedIconTheme: const IconThemeData(color: Colors.black),
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
                      ? const Icon(
                          Icons.home,
                          color: Colors.white,
                          size: 30,
                        )
                      : SvgPicture.asset(
                          "assets/icons/home_icon.svg",
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
                        ? Icons.settings
                        : Icons.settings_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: ''),
            ],
          ),
        ));
  }
}
