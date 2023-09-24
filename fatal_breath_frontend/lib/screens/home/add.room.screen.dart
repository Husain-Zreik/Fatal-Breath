import 'dart:io';

import 'package:fatal_breath_frontend/enums/room.types.dart';
import 'package:fatal_breath_frontend/providers/house.provider.dart';
import 'package:fatal_breath_frontend/providers/room.provider.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/utils/text.error.dart';
import 'package:fatal_breath_frontend/widgets/button.global.dart';
import 'package:fatal_breath_frontend/widgets/drop.down.dart';
import 'package:fatal_breath_frontend/widgets/secondary.appbar.dart';
import 'package:fatal_breath_frontend/widgets/text.form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddRoomScreen extends StatefulWidget {
  const AddRoomScreen({Key? key, required this.houseId}) : super(key: key);

  final int houseId;

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController oldpasswordController = TextEditingController();
  final _form = GlobalKey<FormState>();

  String? _selectedType;
  List<String> roomTypes = RoomTypes.roomTypes;

  String err = "";
  bool validated() {
    return _form.currentState!.validate();
  }

  Future createPressed(name, type, house, context) async {
    try {
      setState(() {
        err = "";
      });

      if (!validated()) {
        return err = "Fill the inputs correctly";
      }

      await Provider.of<RoomProvider>(context, listen: false)
          .createRoom(name, type, house, context);

      await Provider.of<HouseProvider>(context, listen: false).getAdminHouses();

      Get.back();
    } on HttpException catch (error) {
      setState(() {
        err = error.message;
      });
    }
  }

  inputvalidator(value) {
    if (value!.isEmpty) {
      return "Please enter the room name";
    } else if (value.length > 12) {
      return "The room name must not exceed 12 characters";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SecondaryAppBar(title: "Add Room"),
      ),
      backgroundColor: GlobalColors.bgColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  TextForm(
                    textInputType: TextInputType.text,
                    controller: nameController,
                    label: 'Room Name',
                    hintText: 'Enter the room name',
                    isPass: false,
                    validator: inputvalidator,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomDropdown<String>(
                    label: 'Select Room Type',
                    value: _selectedType,
                    items: roomTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedType = newValue;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ButtonGlobal(
                      text: 'Create',
                      bgColor: GlobalColors.mainColor,
                      textColor: Colors.white,
                      onBtnPressed: () {
                        createPressed(nameController.text, _selectedType,
                            widget.houseId, context);
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  TextError(text: err),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
