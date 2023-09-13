import 'dart:io';

import 'package:fatal_breath_frontend/models/country.modal.dart';
import 'package:fatal_breath_frontend/providers/house.provider.dart';
import 'package:fatal_breath_frontend/screens/home.screen.dart';
import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/utils/text.error.dart';
import 'package:fatal_breath_frontend/widgets/button.global.dart';
import 'package:fatal_breath_frontend/widgets/drop.down.dart';
import 'package:fatal_breath_frontend/widgets/secondary.appbar.dart';
import 'package:fatal_breath_frontend/widgets/text.form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddHouseScreen extends StatefulWidget {
  const AddHouseScreen({Key? key}) : super(key: key);

  @override
  State<AddHouseScreen> createState() => _AddHouseScreenState();
}

class _AddHouseScreenState extends State<AddHouseScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController oldpasswordController = TextEditingController();
  final _form = GlobalKey<FormState>();

  String? _selectedCountry;
  String? _selectedCity;

  List<String> countries = CountryData.countries;
  Map<String, List<String>> citiesByCountry = CountryData.citiesByCountry;

  String err = "";
  bool validated() {
    return _form.currentState!.validate();
  }

  Future createPressed(name, country, city, context) async {
    try {
      setState(() {
        err = "";
      });

      if (!validated()) {
        return err = "Fill the inputs correctly";
      }
      //Try signing up
      await Provider.of<HouseProvider>(context, listen: false)
          .createHouse(name, country, city, context);

      await Provider.of<HouseProvider>(context, listen: false).getAdminHouses();

      //Navigation
      Get.to(() => const HomeScreen());
      // Get.back();
    } on HttpException catch (error) {
      setState(() {
        err = error.message;
      });
    }
  }

  inputvalidator(value) {
    if (value!.isEmpty) {
      return "Please re-enter your password";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SecondaryAppBar(title: "Add House"),
      ),
      backgroundColor: GlobalColors.bgColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
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
                    label: 'House Name',
                    hintText: 'Enter the house name',
                    isPass: false,
                    validator: inputvalidator,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomDropdown<String>(
                    label: 'Select Country',
                    value: _selectedCountry,
                    items: countries.map((String country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(country),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCountry = newValue;
                        _selectedCity = null;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomDropdown<String>(
                    label: 'Select City',
                    value: _selectedCity,
                    items: _selectedCountry != null
                        ? citiesByCountry[_selectedCountry!]
                                ?.toSet()
                                .map((String city) {
                              return DropdownMenuItem<String>(
                                value: city,
                                child: Text(city),
                              );
                            }).toList() ??
                            []
                        : [],
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCity = newValue;
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
                        createPressed(nameController.text, _selectedCountry,
                            _selectedCity, context);
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
