import 'package:fatal_breath_frontend/screens/home/add.house.screen.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/widgets/add.box.dart';
import 'package:fatal_breath_frontend/widgets/delete.house.box.dart';
import 'package:fatal_breath_frontend/widgets/secondary.appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditHousesScreen extends StatelessWidget {
  const EditHousesScreen({Key? key, this.houses}) : super(key: key);

  final List? houses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: SecondaryAppBar(title: "Edit Houses"),
        ),
        backgroundColor: GlobalColors.bgColor,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 30, top: 10),
          child: Column(children: [
            InkWell(
              onTap: () {
                Get.to(() => const AddHouseScreen());
              },
              child: const AddBox(label: "Add House"),
            ),
            for (final house in houses!) DeleteHouseBox(house: house)
          ]),
        )));
  }
}
