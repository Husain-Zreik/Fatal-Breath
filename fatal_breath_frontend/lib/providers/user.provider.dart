import 'dart:io';

import 'package:fatal_breath_frontend/config/remote.config.dart';
import 'package:flutter/cupertino.dart';

class User with ChangeNotifier {
  String? name;
  String? username;
  String? email;
  String? userType;

  String? get getName {
    return name;
  }

  String? get getUsername {
    return username;
  }

  String? get getEmail {
    return email;
  }

  String? get getUserType {
    return userType;
  }

  //Get user data
  Future getUser(context) async {
    try {
      final response = await sendRequest(route: "/api/user/info");

      name = response['user']["name"];
      username = response['user']["username"];
      email = response['user']["email"];

      if (response['user']["role"] == 1) {
        userType = "Admin";
      } else {
        userType = "User";
      }

      notifyListeners();
    } catch (e) {
      throw HttpException('$e');
    }
  }

  Future updateProfile() async {}
}
