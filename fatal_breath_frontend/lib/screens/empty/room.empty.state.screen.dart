import 'package:fatal_breath_frontend/screens/home/add.room.screen.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/utils/text.note.dart';
import 'package:fatal_breath_frontend/utils/text.title.dart';
import 'package:fatal_breath_frontend/widgets/button.global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomEmptyStateScreen extends StatelessWidget {
  const RoomEmptyStateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextTitle(text: "Your Rooms"),
            const SizedBox(height: 10),
            const TextNote(text: "Get started by adding your rooms"),
            const SizedBox(height: 30),
            ButtonGlobal(
              bgColor: GlobalColors.mainColor,
              textColor: Colors.white,
              icon: Icons.add,
              onBtnPressed: () {
                Get.to(() => const AddRoomScreen());
              },
            )
          ],
        ),
      ),
    );
  }
}
