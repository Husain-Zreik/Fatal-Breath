// ignore_for_file: avoid_print

import 'dart:io';

import 'package:fatal_breath_frontend/config/remote.config.dart';
import 'package:fatal_breath_frontend/enums/request.methods.dart';
import 'package:flutter/cupertino.dart';

class User with ChangeNotifier {
  String? name;
  String? username;
  String? email;
  String? image;
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

  String? get getImage {
    if (image != null) {
      debugPrint("$baseUrl/storage/$image");
      return "$baseUrl/storage/$image";
    }

    return "null";
    // return null;
  }

  //Get user data
  Future getUser(context) async {
    try {
      final response = await sendRequest(route: "/api/user/info");

      name = response['user']["name"];
      username = response['user']["username"];
      email = response['user']["email"];
      image = response['user']["profile_image"];

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

  Future updateProfile(
    name1,
    username1,
    email1,
    profileImage1,
    BuildContext context,
  ) async {
    try {
      final body = {
        'name': name1,
        'username': username1,
        'email': email1,
        'profile_image': profileImage1,
      };

      final response = await sendRequest(
          route: "/api/user/info/update",
          method: RequestMethods.POST,
          load: body);
      print(response);

      name = response['user']["name"];
      username = response['user']["username"];
      email = response['user']["email"];
      image = response['user']["profile_image"];

      notifyListeners();
    } catch (error) {
      throw HttpException('$error');
    }
  }
}
