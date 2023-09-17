// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
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

  Future fetchWeather(city, country) async {
    const apiKey = '232dfd47c590be56ac3d87bf82aab944';
    // const apiKey = '914536411a15b4683380209ccf43fb0f';
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city,$country&units=metric&appid=$apiKey';
    final dio = Dio();

    try {
      final response = await dio.get(
        apiUrl,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> weatherData = {
          'temp': response.data['main']['temp'],
          'humidity': response.data['main']['humidity'],
          'wind': response.data['wind']['speed'],
        };

        return weatherData;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw HttpException('$e');
    }
  }

  Future<Map<String, dynamic>> fetchWeather1(city, country, context) async {
    const apiKey = '232dfd47c590be56ac3d87bf82aab944';
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city,$country&units=metric&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE'
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> weatherData = {
          'temp': json.decode(response.body)['main']['temp'],
          'humidity': json.decode(response.body)['main']['humidity'],
          'wind': json.decode(response.body)['wind']['speed'],
        };

        return weatherData;
      } else if (response.statusCode == 404) {
        throw Exception('Not found');
      } else if (response.statusCode == 500) {
        throw Exception('Server not responding');
      } else {
        throw Exception('Some other error');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
