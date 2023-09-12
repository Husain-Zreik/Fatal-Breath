import 'dart:io';

import 'package:fatal_breath_frontend/config/remote.config.dart';
import 'package:fatal_breath_frontend/enums/request.methods.dart';
import 'package:flutter/material.dart';

class HouseProvider with ChangeNotifier {
  String? houseName;

  String? get getHouseName {
    return houseName;
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
}
