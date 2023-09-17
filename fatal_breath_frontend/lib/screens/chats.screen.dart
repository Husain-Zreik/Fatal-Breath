import 'package:fatal_breath_frontend/providers/house.provider.dart';
import 'package:fatal_breath_frontend/screens/empty/home.empty.state.screen.dart';
import 'package:fatal_breath_frontend/screens/messages.screen.dart';
import 'package:fatal_breath_frontend/utils/text.note.dart';
import 'package:fatal_breath_frontend/widgets/contact.box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List? houses;
  List? members;

  @override
  void initState() {
    super.initState();
    Provider.of<HouseProvider>(context, listen: false).getAdminHouses();
  }

  @override
  Widget build(BuildContext context) {
    houses = Provider.of<HouseProvider>(context).getHouses ?? [];
    members = Provider.of<HouseProvider>(context).getMembers ?? [];
    return houses!.isEmpty
        ? const HomeEmptyStateScreen()
        : members!.isEmpty
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextNote(
                      text: "No members in your houses go and invite some.")
                ],
              )
            : SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 5, right: 5, bottom: 30),
                    child: Column(
                      children: [
                        for (final user in members!)
                          InkWell(
                            onTap: () {
                              Get.to(() => MessagesScreen(user: user));
                            },
                            child: ContactBox(
                              user: user,
                            ),
                          ),
                      ],
                    )));
  }
}
