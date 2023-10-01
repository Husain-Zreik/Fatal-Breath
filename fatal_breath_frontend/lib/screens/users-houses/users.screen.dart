import 'dart:async';

import 'package:fatal_breath_frontend/providers/house.provider.dart';
import 'package:fatal_breath_frontend/providers/user.provider.dart';
import 'package:fatal_breath_frontend/screens/empty/home.empty.state.screen.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/utils/text.note.dart';
import 'package:fatal_breath_frontend/widgets/contact.box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  Map<int, TextEditingController> searchControllers = {};
  Map<int, List> searchLists = {};
  Map<int, String> searchTerms = {};

  Timer? _debounce;
  String? image;
  List? houses;
  bool isSearch = false;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future removePressed(houseId, userId, context) async {
    await Provider.of<HouseProvider>(context, listen: false)
        .removeMember(houseId, userId, context);
  }

  Future handleRequest(houseId, userId, status, context) async {
    await Provider.of<HouseProvider>(context, listen: false)
        .processRequest(houseId, userId, status, context);
  }

  Future searchPressed(houseId) async {
    setState(() {
      searchTerms[houseId] =
          searchControllers[houseId]!.text.replaceAll(' ', '');
    });
    if (searchTerms[houseId]!.isNotEmpty) {
      await Provider.of<UserProvider>(context, listen: false)
          .usernameSearch(searchTerms[houseId], houseId, context);
      setState(() {
        searchLists[houseId] =
            Provider.of<UserProvider>(context, listen: false).getSearchList!;
        isSearch = true;
      });
    } else {
      setState(() {
        isSearch = false;
      });
      Provider.of<UserProvider>(context, listen: false).clearSearchList();
    }
  }

  Future toggleInvitePressed(houseId, userId, searchTerm, context) async {
    await Provider.of<HouseProvider>(context, listen: false)
        .toggleInvite(houseId, userId, context);

    await Provider.of<UserProvider>(context, listen: false)
        .usernameSearch(searchTerm, houseId, context);
    setState(() {
      searchLists[houseId] =
          Provider.of<UserProvider>(context, listen: false).getSearchList!;
      isSearch = true;
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<HouseProvider>(context, listen: false).getAdminHouses();
    image = Provider.of<UserProvider>(context, listen: false).getImage;
  }

  @override
  Widget build(BuildContext context) {
    houses = Provider.of<HouseProvider>(context).getHouses ?? [];
    for (final house in houses!) {
      searchControllers[house.id]?.text == null
          ? searchControllers[house.id] = TextEditingController()
          : null;
      searchTerms[house.id];
    }
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
            child: Text(
              "Edit Members",
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
            ? const HomeEmptyStateScreen()
            : TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  for (final house in houses!)
                    SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Column(children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          height: 50,
                          child: TextField(
                              keyboardType: TextInputType.text,
                              controller: searchControllers[house.id],
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
                                    searchPressed(house.id);
                                  },
                                ),
                              ),
                              onChanged: (term) {
                                if (_debounce != null) {
                                  _debounce!.cancel();
                                }
                                _debounce = Timer(
                                    const Duration(milliseconds: 1500), () {
                                  searchPressed(house.id);
                                });
                              }),
                        ),
                        if (isSearch &&
                            searchLists[house.id] != null &&
                            searchLists[house.id]!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 22, top: 15),
                                child: Text(
                                  "Results :",
                                  style: GoogleFonts.poppins(
                                    color: GlobalColors.mainColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              for (final user in searchLists[house.id]!)
                                ContactBox(
                                  user: user,
                                  child: InkWell(
                                    onTap: () {
                                      toggleInvitePressed(house.id, user.id,
                                          searchTerms[house.id], context);
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: user.isInvited
                                            ? Colors.white
                                            : Colors.blue,
                                        border: Border.all(
                                          color: Colors.blue,
                                          width: 2.0,
                                        ),
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
                                        child: Text(
                                            user.isInvited
                                                ? "Invited"
                                                : "Invite",
                                            style: GoogleFonts.poppins(
                                              color: user.isInvited
                                                  ? Colors.blue
                                                  : Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        if (!isSearch &&
                            house.members != null &&
                            house.members!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 22, top: 15),
                                child: Text(
                                  "Members of ${house.name} :",
                                  style: GoogleFonts.poppins(
                                    color: GlobalColors.mainColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              for (final member in house.members!)
                                ContactBox(
                                  user: member,
                                  child: InkWell(
                                    onTap: () {
                                      removePressed(
                                          house.id, member.id, context);
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
                                        child: Text("Remove",
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
                        if (!isSearch &&
                            house.requests != null &&
                            house.requests!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 22, top: 15),
                                child: Text(
                                  "Requests :",
                                  style: GoogleFonts.poppins(
                                    color: GlobalColors.mainColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              for (final request in house.requests!)
                                ContactBox(
                                  user: request,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          handleRequest(house.id, request.id,
                                              "Accept", context);
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            color: Colors.blue,
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
                                          handleRequest(house.id, request.id,
                                              "Decline", context);
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            color: Colors.red,
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
                        if (!isSearch &&
                            house.requests == null &&
                            house.members == null)
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 80, right: 20, left: 25),
                            child: TextNote(
                                text:
                                    "No requests or members in this house ! Search for members and invite them by typing their username."),
                          )
                        else if (isSearch &&
                            searchLists[house.id] != null &&
                            searchLists[house.id]!.isEmpty)
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 20, right: 20, left: 23),
                            child: TextNote(text: "User Not Found."),
                          )
                      ]),
                    ))
                ],
              ),
      ),
    );
  }
}
