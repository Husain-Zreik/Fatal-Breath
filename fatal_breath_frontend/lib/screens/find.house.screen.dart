import 'package:fatal_breath_frontend/providers/house.provider.dart';
import 'package:fatal_breath_frontend/providers/user.provider.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FindHouseScreen extends StatefulWidget {
  const FindHouseScreen({Key? key}) : super(key: key);

  @override
  State<FindHouseScreen> createState() => _FindHouseScreenState();
}

class _FindHouseScreenState extends State<FindHouseScreen> {
  String? image;
  List? houses;

  @override
  void initState() {
    super.initState();
    Provider.of<HouseProvider>(context, listen: false).getUserHouses();
  }

  @override
  Widget build(BuildContext context) {
    houses = Provider.of<HouseProvider>(context).getHouses ?? [];
    image = Provider.of<UserProvider>(context, listen: false).getImage;
    return Scaffold(
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
            child: Text(
              "Find House",
              style: GoogleFonts.poppins(
                color: GlobalColors.mainColor,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 17, bottom: 10, right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  width: 53,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: image == null
                      ? Image.asset(
                          'assets/images/account_circle.png',
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          image!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          ],
        ));
  }
}
