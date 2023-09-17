// ignore_for_file: avoid_print

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

  // Future fetchWeather1(city, country) async {
  //   const apiKey = '232dfd47c590be56ac3d87bf82aab944';
  //   // const apiKey = '914536411a15b4683380209ccf43fb0f';
  //   final apiUrl =
  //       'https://api.openweathermap.org/data/2.5/weather?q=$city,$country&units=metric&appid=$apiKey';
  //   final dio = Dio();

  //   try {
  //     final response = await dio.get(
  //       apiUrl,
  //     );

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> weatherData = {
  //         'temp': response.data['main']['temp'],
  //         'humidity': response.data['main']['humidity'],
  //         'wind': response.data['wind']['speed'],
  //       };

  //       return weatherData;
  //     } else {
  //       throw Exception('Failed to load weather data');
  //     }
  //   } catch (e) {
  //     throw HttpException('$e');
  //   }
  // }

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
