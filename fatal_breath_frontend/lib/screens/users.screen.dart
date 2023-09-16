import 'package:fatal_breath_frontend/providers/house.provider.dart';
import 'package:fatal_breath_frontend/providers/user.provider.dart';
import 'package:fatal_breath_frontend/screens/empty/home.empty.state.screen.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/utils/text.note.dart';
import 'package:fatal_breath_frontend/widgets/profile.circle.dart';
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

  String? image;
  List? houses;
  List? searchList = [];

  Future removePressed(houseId, userId, context) async {
    await Provider.of<HouseProvider>(context, listen: false)
        .removeMember(houseId, userId, context);
  }

  Future handleRequest(houseId, userId, status, context) async {
    await Provider.of<HouseProvider>(context, listen: false)
        .handleRequest(houseId, userId, status, context);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<HouseProvider>(context, listen: false).getAdminHouses();
  }

  @override
  Widget build(BuildContext context) {
    houses = Provider.of<HouseProvider>(context).getHouses ?? [];
    image = Provider.of<UserProvider>(context, listen: false).getImage;
    for (final house in houses!) {
      searchControllers[house.id] = TextEditingController();
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
              padding: const EdgeInsets.only(top: 15, bottom: 5, right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  width: 60,
                  // height: 15,
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
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                          height: 50,
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: searchControllers[house.id],
                            decoration: InputDecoration(
                              hintText: 'Search users...',
                              prefixIcon: Icon(
                                Icons.search,
                                color: GlobalColors.mainColor,
                              ),
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
                            ),
                            onSubmitted: (value) async {
                              String searchTerm = searchControllers[house.id]!
                                  .text
                                  .replaceAll(' ', '');
                              // print("Search Term $searchTerm");
                              // print("Search list $searchList");
                              if (searchTerm.isNotEmpty) {
                                await Provider.of<UserProvider>(context,
                                        listen: false)
                                    .usernameSearch(
                                        searchTerm, house.id, context);
                                setState(() {
                                  searchLists[house.id] =
                                      Provider.of<UserProvider>(context,
                                              listen: false)
                                          .getSearchList!;
                                });
                              } else {
                                setState(() {
                                  searchLists[house.id] = [];
                                });
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .clearSearchList();
                              }
                            },
                          ),
                        ),
                        if (searchLists[house.id] != null &&
                            searchLists[house.id]!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 22, top: 5),
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
                                Container(
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
                                                child: ProfileCircle(
                                                  size: 60,
                                                  imageLink: user
                                                              .profileImage !=
                                                          null
                                                      ? 'http://192.168.1.5:8000/storage/profile_images/${user.id}.png'
                                                      : null,
                                                )),
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(user.username,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(user.name,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {},
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
                                              child: Text("Invite",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        if (house.members != null &&
                            house.members!.isNotEmpty &&
                            searchLists[house.id] == null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 22, top: 5),
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
                                Container(
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
                                                child: ProfileCircle(
                                                  size: 60,
                                                  imageLink: member
                                                              .profileImage !=
                                                          null
                                                      ? 'http://192.168.1.5:8000/storage/profile_images/${member.id}.png'
                                                      : null,
                                                )),
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(member.username,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(member.name,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            removePressed(
                                                house.id, member.id, context);
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
                                              child: Text("Remove",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        if (house.requests != null &&
                            house.requests!.isNotEmpty &&
                            searchLists[house.id] == null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 22, top: 5),
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
                                Container(
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
                                                child: ProfileCircle(
                                                  size: 60,
                                                  imageLink: request
                                                              .profileImage !=
                                                          null
                                                      ? 'http://192.168.1.5:8000/storage/profile_images/${request.id}.png'
                                                      : null,
                                                )),
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(request.username,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(request.name,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                handleRequest(
                                                    house.id,
                                                    request.id,
                                                    "Accept",
                                                    context);
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
                                                      offset:
                                                          const Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text("Accept",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                handleRequest(
                                                    house.id,
                                                    request.id,
                                                    "Decline",
                                                    context);
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
                                                      offset:
                                                          const Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text("Decline",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          )
                        else if (house.requests == null &&
                            house.members == null &&
                            searchLists[house.id] == null)
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 20, right: 20, left: 23),
                            child: TextNote(
                                text:
                                    "No requests or members in this house !\nSearch for members and invite them by typing the username of them in the search bar."),
                          )
                        else if (searchLists[house.id]!.isEmpty)
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
