import 'package:fatal_breath_frontend/utils/global.colors.dart';
import 'package:fatal_breath_frontend/utils/text.error.dart';
import 'package:fatal_breath_frontend/widgets/button.global.dart';
import 'package:fatal_breath_frontend/widgets/drop.down.dart';
import 'package:fatal_breath_frontend/widgets/secondary.appbar.dart';
import 'package:fatal_breath_frontend/widgets/text.form.dart';
import 'package:flutter/material.dart';

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

  List<String> countries = [
    'US',
    'CA',
    'LB',
    'FR',
    'DE'
  ]; // Add more countries as needed

  Map<String, List<String>> citiesByCountry = {
    'US': ['New York', 'Los Angeles', 'Chicago', 'Houston', 'Miami'],
    'CA': ['Toronto', 'Vancouver', 'Montreal', 'Calgary', 'Ottawa'],
    'LB': [
      'Beirut',
      'Tripoli',
      'Sidon',
      'Tyre',
      'Zahle',
      'Jounieh',
      'Batroun',
      'Byblos',
      'Nabatieh',
      'Baalbek',
      'Jbeil',
      'Bekaa Valley',
      'Zahlé',
      'Jounieh',
      'Bint Jbeil',
      'Chouf',
      'Marjayoun',
      'Aley',
      'Rashaya',
      'Saida',
      'Zahle',
      'Baalbek',
      'Taanayel',
      'Riyak',
      'Jiyeh',
      'Sour',
      'Ehdin',
      'Hermel',
      'Saghbine',
      'Hasbaya',
      'Bhamdoun',
      'Mazraat Yachouh',
      'Ras el-Matn',
      'Broummana',
      'Aley',
      'Bteghrine',
      'Hosh Hala',
      'Deir el Qamar',
      'Zgharta',
      'Kousba',
      'Miziara',
      'Qoubaiyat',
      'Bechare',
      'Mansoura',
      'Babda',
      'Naccache',
      'Sin el Fil',
      'Horsh Tabet',
      'Baabda',
      'Fanar'
    ],
    'FR': ['Paris', 'Marseille', 'Lyon', 'Toulouse', 'Nice'],
    'DE': ['Berlin', 'Hamburg', 'Munich', 'Cologne', 'Frankfurt'],
  };

  String err = "";
  bool validated() {
    return _form.currentState!.validate();
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
                        ? citiesByCountry[_selectedCountry!]!
                            .map((String city) {
                            return DropdownMenuItem<String>(
                              value: city,
                              child: Text(city),
                            );
                          }).toList()
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
                      text: 'Save',
                      bgColor: GlobalColors.mainColor,
                      textColor: Colors.white,
                      onBtnPressed: () {}),
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
