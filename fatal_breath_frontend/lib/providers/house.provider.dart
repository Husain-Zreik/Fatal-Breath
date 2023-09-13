import 'dart:io';

import 'package:fatal_breath_frontend/config/remote.config.dart';
import 'package:fatal_breath_frontend/enums/request.methods.dart';
import 'package:flutter/material.dart';

class HouseProvider with ChangeNotifier {
  String? houseName;
  List? adminHouses;

  String? get getHouseName {
    return houseName;
  }

  List? get getHouses {
    return adminHouses;
  }

  Future createHouse(name, country, city, context) async {
    try {
      final body = {
        'name': name,
        'city': city,
        'country': country,
      };
      final response = await sendRequest(
          route: "/api/user/admin/add-house",
          method: RequestMethods.POST,
          load: body);
      houseName = response['house']["name"];

      notifyListeners();
    } catch (e) {
      throw HttpException('$e');
    }
  }

  Future getAdminHouses() async {
    try {
      final response = await sendRequest(
        route: "/api/user/admin/get-houses",
        method: RequestMethods.GET,
      );

      final List<dynamic> houseList = response['houses'];
      List<Map<String, dynamic>> houses = [];

      for (var houseData in houseList) {
        Map<String, dynamic> house = {
          'name': houseData['name'],
          'city': houseData['city'],
          'country': houseData['country'],
        };
        houses.add(house);
      }

      adminHouses = houses;

      notifyListeners();
    } catch (e) {
      throw HttpException('$e');
    }
  }
}
