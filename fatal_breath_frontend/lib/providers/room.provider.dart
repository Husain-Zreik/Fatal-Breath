// ignore_for_file: avoid_print

import 'dart:convert';
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

  Future fetchWeather(country, city, context) async {
    try {
      const apiKey = '232dfd47c590be56ac3d87bf82aab944';
      const apiUrl = 'https://api.openweathermap.org/data/2.5/weather';

      final response = await sendRequest(
        route: "'$apiUrl?q=$city,$country&units=metric&appid=$apiKey'",
        method: RequestMethods.GET,
      );

      final data = json.decode(response);

      final body = {
        'temp': data.main.temp,
        'humidity': data.main.humidity,
        'wind': data.wind.speed,
      };

      return body;
    } catch (e) {
      throw HttpException('$e');
    }
  }
}
