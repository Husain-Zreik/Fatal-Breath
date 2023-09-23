import 'package:fatal_breath_frontend/models/user.model.dart';
import 'package:fatal_breath_frontend/providers/house.provider.dart';
import 'package:fatal_breath_frontend/providers/user.provider.dart';
import 'package:fatal_breath_frontend/screens/empty/home.empty.state.screen.dart';
import 'package:fatal_breath_frontend/screens/chats/messages.screen.dart';
import 'package:fatal_breath_frontend/screens/empty/user.empty.state.screen.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/widgets/contact.box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List? houses;
  List? members;
  String? image;
  String? userType;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    userType = Provider.of<UserProvider>(context, listen: false).getUserType;
    currentUser =
        Provider.of<UserProvider>(context, listen: false).getCurrentUser;

    if (userType == "Manager") {
      Provider.of<HouseProvider>(context, listen: false).getAdminHouses();
    } else {
      Provider.of<HouseProvider>(context, listen: false).getUserHouses();
    }
  }

  @override
  Widget build(BuildContext context) {
    houses = Provider.of<HouseProvider>(context).getHouses ?? [];
    members = Provider.of<HouseProvider>(context).getMembers ?? [];
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
                    'CHAT',
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
                  Container(
                    height: 10,
                    width: 10,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("Online",
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
      ),
      body: houses!.isEmpty && userType == "Manager"
          ? const HomeEmptyStateScreen()
          : houses!.isEmpty && userType == "User"
              ? const UserEmptyStateScreen(
                  text: "You are not a member in any house")
              : members!.isEmpty
                  ? const UserEmptyStateScreen(
                      text: "No members in your houses")
                  : SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 5, right: 5, bottom: 30),
                          child: Column(
                            children: [
                              for (final user in members!)
                                InkWell(
                                  onTap: () {
                                    Get.to(() => MessagesScreen(
                                        user: user, currentUser: currentUser!));
                                  },
                                  child: ContactBox(
                                    user: user,
                                  ),
                                ),
                            ],
                          ))),
    );
  }
}
