import 'package:fatal_breath_frontend/providers/house.provider.dart';
import 'package:fatal_breath_frontend/providers/user.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindHouseScreen extends StatefulWidget {
  const FindHouseScreen({Key? key}) : super(key: key);

  @override
  State<FindHouseScreen> createState() => _FindHouseScreenState();
}

class _FindHouseScreenState extends State<FindHouseScreen> {
  String? image;
  List? houses;

  @override
  void initState() {
    super.initState();
    Provider.of<HouseProvider>(context, listen: false).getUserHouses();
  }

  @override
  Widget build(BuildContext context) {
    houses = Provider.of<HouseProvider>(context).getHouses ?? [];
    image = Provider.of<UserProvider>(context, listen: false).getImage;
    return Container();
  }
}
