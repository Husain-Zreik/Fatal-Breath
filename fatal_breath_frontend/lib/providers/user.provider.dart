import 'dart:io';

import 'package:fatal_breath_frontend/config/remote.config.dart';
import 'package:flutter/cupertino.dart';

class User with ChangeNotifier {
  String? email;
  String? userType;
  String? currentSystemId;

  String? get getCurrentSystemId {
    return currentSystemId;
  }

  String? get getEmail {
    return email;
  }

  //Setting current system
  void setCurrentSystemId(String systemId) {
    currentSystemId = systemId;
    notifyListeners();
  }

  //Get user data
  Future getUser(String id, context) async {
    try {
      final response = await sendRequest(route: "/read/$id");

      if (response["message"] != null) {
        throw HttpException(response["message"]);
      }

      email = response["email"];
      userType = response["user_type"];

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
