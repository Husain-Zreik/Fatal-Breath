import 'dart:io';
import 'package:fatal_breath_frontend/config/remote.config.dart';
import 'package:fatal_breath_frontend/enums/request.methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? userId;
  String? token;

  String? get getUserId {
    if (userId != null) {
      return userId;
    }

    return null;
  }

  String? get getToken {
    if (token != null) {
      return token;
    }

    return null;
  }

  //Login
  Future login(email, password, context) async {
    try {
      final response = await sendRequest(
          route: "/api/auth/login",
          method: RequestMethods.POST,
          load: {
            "email": email,
            "password": password,
          });

      // print(response.data);

      final userData = response.data['user'];

      // if (message != null) {
      //   throw HttpException(message);
      // }

      // Save user id and token with the correct types
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("user_id", userData['id'].toString());
      await prefs.setString("token", userData['token']);

      // final message = response.data['status'];
      userId = userData['id'].toString();
      token = userData['token'];
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  //Sign up
  Future signUp(email, password, userType, context) async {
    try {
      final response = await sendRequest(
        method: RequestMethods.POST,
        route: "/auth/signup",
        load: {
          "email": email,
          "password": password,
          "user_type": userType,
        },
      );

      if (response["message"] != null) {
        throw HttpException(response["message"]);
      }

      //Save user id and token
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("user_id", response["user_id"]);
      await prefs.setString("token", response["token"]);

      userId = response["user_id"];
      token = response["token"];
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  //Log out
  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    userId = null;
    token = null;
    notifyListeners();
  }
}
