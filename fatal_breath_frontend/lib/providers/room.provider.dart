// ignore_for_file: avoid_print

import 'dart:io';

import 'package:fatal_breath_frontend/config/remote.config.dart';
import 'package:fatal_breath_frontend/enums/request.methods.dart';
import 'package:flutter/material.dart';

class RoomProvider with ChangeNotifier {
  Future createRoom(name, type, house, context) async {
    try {
      final body = {
        'name': name,
        'type': type,
        'house_id': house,
      };
      final response = await sendRequest(
          route: "/api/user/admin/add-room",
          method: RequestMethods.POST,
          load: body);

      print(response);

      notifyListeners();
    } catch (e) {
      throw HttpException('$e');
    }
  }
}
