import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
      await sendRequest(
          route: "/api/user/admin/add-room",
          method: RequestMethods.POST,
          load: body);

      notifyListeners();
    } catch (e) {
      throw HttpException('$e');
    }
  }

  Future<Map<String, dynamic>> fetchWeather(String city, String country) async {
    const apiKey = 'e7c02a9f01c54d44a33133922231709';
    final apiUrl =
        'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city,$country';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> weatherData = {
          'temp': json.decode(response.body)['current']['temp_c'],
          'humidity': json.decode(response.body)['current']['humidity'],
          'wind': json.decode(response.body)['current']['wind_kph'],
        };

        return weatherData;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
