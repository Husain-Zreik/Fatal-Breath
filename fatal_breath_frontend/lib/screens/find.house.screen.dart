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

  String? image;
  List? houses;
  List? searchList;

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
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 5),
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
                    // searchPressed(house.id);
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
                  padding: const EdgeInsets.only(left: 22, top: 5),
                  child: Text(
                    "Results :",
                    style: GoogleFonts.poppins(
                      color: GlobalColors.mainColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                for (final user in searchList!)
                  ContactBox(
                    user: user,
                    child: InkWell(
                      onTap: () {},
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
                          child: Text(user.isInvited ? "Cancel" : "Request",
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
            )
          else if (searchList != null && searchList!.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 20, right: 20, left: 23),
              child: TextNote(text: "House Not Found."),
            )
          else
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  UserEmptyStateScreen(text: "Search for a house"),
                ],
              ),
            ),
        ]),
      )),
    );
  }
}