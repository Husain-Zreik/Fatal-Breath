// ignore_for_file: avoid_print

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fatal_breath_frontend/config/remote.config.dart';
import 'package:fatal_breath_frontend/enums/request.methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProviders with ChangeNotifier {
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

      // Save user id and token with the correct types
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("user_id", response['user']['id'].toString());
      await prefs.setString("token", response['user']['token']);

      userId = response['user']['id'].toString();
      token = response['user']['token'];

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        switch (e.response?.statusCode) {
          case 401:
            throw const HttpException(
                "Invalid credentials. Please check your email and password.");
          case 403:
            throw const HttpException(
                "You do not have permission to access this resource.");
          case 404:
            throw const HttpException(
                "The resource you are looking for does not exist.");
          default:
            throw const HttpException("An unexpected error occurred.");
        }
      } else {
        throw HttpException('$e');
      }
    }
  }

  //Sign up
  Future signUp(name, username, email, password, role, context) async {
    try {
      final response = await sendRequest(
        method: RequestMethods.POST,
        route: "/api/auth/register",
        load: {
          "name": name,
          "username": username,
          "email": email,
          "password": password,
          "role": role,
        },
      );

      //Save user id and token
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("user_id", response['user']['id'].toString());
      await prefs.setString("token", response['user']['token']);

      userId = response['user']['id'].toString();
      token = response['user']['token'];

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        if (e.response?.data['errors'] != null) {
          if (e.response?.data['errors']['username'] != null) {
            final usererr =
                e.response?.data['errors']['username'][0].toString();
            throw HttpException(usererr!);
          } else if (e.response?.data['errors']['email'] != null) {
            final emailerr = e.response?.data['errors']['email'][0].toString();
            throw HttpException(emailerr!);
          }
        } else {
          throw const HttpException("An unexpected error occurred.");
        }
      } else {
        throw HttpException('$e');
      }
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
