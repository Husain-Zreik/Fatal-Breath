import 'package:fatal_breath_frontend/providers/house.provider.dart';
import 'package:fatal_breath_frontend/screens/empty/home.empty.state.scree.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List? houses;

  @override
  void initState() {
    super.initState();

    houses = Provider.of<HouseProvider>(context, listen: false).getAdminHouses!;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
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
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "Home",
              style: GoogleFonts.poppins(
                color: GlobalColors.mainColor,
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          bottom: houses == null
              ? null
              : const TabBar(
                  tabs: [
                    Tab(text: 'Created Houses'),
                    Tab(text: 'Other Tab'),
                    Tab(text: 'Other Tab'),
                    Tab(text: 'Other Tab'),
                    Tab(text: 'Other Tab'),
                  ],
                ),
        ),
        body: houses == null
            ? const HomeEmptyStateScree()
            : const TabBarView(
                children: [
                  Center(
                    child: Text('List of Created Houses Goes Here'),
                  ),
                  Center(
                    child: Text('Other tabs Go Here'),
                  ),
                  Center(
                    child: Text('Other tabs Go Here'),
                  ),
                  Center(
                    child: Text('Other tabs Go Here'),
                  ),
                  Center(
                    child: Text('Other tabs Go Here'),
                  ),
                ],
              ),
      ),
    );
  }
}
