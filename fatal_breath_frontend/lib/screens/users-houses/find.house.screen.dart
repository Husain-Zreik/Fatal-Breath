import 'package:fatal_breath_frontend/models/user.model.dart';
import 'package:fatal_breath_frontend/providers/house.provider.dart';
import 'package:fatal_breath_frontend/providers/user.provider.dart';
import 'package:fatal_breath_frontend/screens/empty/user.empty.state.screen.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/utils/text.note.dart';
import 'package:fatal_breath_frontend/widgets/contact.box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FindHouseScreen extends StatefulWidget {
  const FindHouseScreen({Key? key}) : super(key: key);

  @override
  State<FindHouseScreen> createState() => _FindHouseScreenState();
}

class _FindHouseScreenState extends State<FindHouseScreen> {
  final TextEditingController searchController = TextEditingController();

  String? searchTerm;
  String? image;
  User? user;
  List? houses;
  List? invitations;
  List? searchList;

  Future leavePressed(houseId, userId, context) async {
    await Provider.of<HouseProvider>(context, listen: false)
        .removeMember(houseId, userId, context);
  }

  Future handleInvitation(houseId, userId, status, context) async {
    await Provider.of<HouseProvider>(context, listen: false)
        .processInvitation(houseId, userId, status, context);
  }

  Future searchPressed() async {
    setState(() {
      searchTerm = searchController.text.replaceAll(' ', '');
    });
    if (searchTerm!.isNotEmpty) {
      await Provider.of<UserProvider>(context, listen: false)
          .houseSearch(searchTerm, context);
      setState(() {
        searchList =
            Provider.of<UserProvider>(context, listen: false).getSearchList!;
      });
    } else {
      setState(() {
        searchList = [];
      });
      Provider.of<UserProvider>(context, listen: false).clearSearchList();
    }
  }

  Future toggleRequestPressed(houseId, userId, searchTerm, context) async {
    await Provider.of<HouseProvider>(context, listen: false)
        .toggleRequest(houseId, userId, context);

    await Provider.of<UserProvider>(context, listen: false)
        .houseSearch(searchTerm, context);
    setState(() {
      searchList =
          Provider.of<UserProvider>(context, listen: false).getSearchList!;
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<HouseProvider>(context, listen: false).getUserHouses();
  }

  @override
  Widget build(BuildContext context) {
    houses = Provider.of<HouseProvider>(context).getHouses ?? [];
    invitations = Provider.of<HouseProvider>(context).getInvitations ?? [];
    user = Provider.of<UserProvider>(context, listen: false).getCurrentUser;
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
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            height: 50,
            child: TextField(
              keyboardType: TextInputType.text,
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search users...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.search,
                    color: GlobalColors.mainColor,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    searchPressed();
                  },
                ),
              ),
            ),
          ),
          if (searchList != null && searchList!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 22, top: 20),
                  child: Text(
                    "Results :",
                    style: GoogleFonts.poppins(
                      color: GlobalColors.mainColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                for (final house in searchList!)
                  ContactBox(
                    user: house.owner,
                    houseName: house.name,
                    child: InkWell(
                      onTap: () {
                        toggleRequestPressed(
                            house.id, user!.id, searchTerm, context);
                      },
                      child: Container(
                        height: 25,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.blue,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child:
                              Text(house.isRequested ? "Requested" : "Request",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  )),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          if (houses != null && houses!.isNotEmpty && searchList == null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 22, top: 20),
                  child: Text(
                    "Member of these houses :",
                    style: GoogleFonts.poppins(
                      color: GlobalColors.mainColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                for (final house in houses!)
                  ContactBox(
                    user: house.owner,
                    houseName: house.name,
                    child: InkWell(
                      onTap: () {
                        leavePressed(house.id, user!.id, context);
                      },
                      child: Container(
                        height: 25,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
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
                        child: Center(
                          child: Text("Leave",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          if (invitations != null &&
              invitations!.isNotEmpty &&
              searchList == null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 22, top: 20),
                  child: Text(
                    "Invitations :",
                    style: GoogleFonts.poppins(
                      color: GlobalColors.mainColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                for (final house in invitations!)
                  ContactBox(
                    user: house.owner,
                    houseName: house.name,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            handleInvitation(
                                house.id, user!.id, "Accept", context);
                          },
                          child: Container(
                            height: 25,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.blue,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text("Accept",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            handleInvitation(
                                house.id, user!.id, "Decline", context);
                          },
                          child: Container(
                            height: 25,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
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
                            child: Center(
                              child: Text("Decline",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          if (searchList != null && searchList!.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 20, right: 20, left: 23),
              child: TextNote(text: "House Not Found."),
            ),
          if (searchList == null && invitations!.isEmpty && houses!.isEmpty)
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  UserEmptyStateScreen(
                    text: "",
                    isSearch: true,
                  ),
                ],
              ),
            ),
        ]),
      )),
    );
  }
}
