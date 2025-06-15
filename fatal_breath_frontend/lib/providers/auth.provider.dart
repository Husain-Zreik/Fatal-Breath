import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fatal_breath_frontend/config/remote.config.dart';
import 'package:fatal_breath_frontend/enums/request.methods.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

Future<String> getDeviceName() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.model;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.utsname.machine;
  }
  return 'Unknown Device';
}

class AuthProvider with ChangeNotifier {
  int? userId;
  String? token;
  String? password;

  int? get getUserId => userId;
  String? get getToken => token;
  String? get getPassword => password;

  Future login(String email, String password1, BuildContext context) async {
    try {
      String deviceName = await getDeviceName();
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      // Prepare the login payload with device info and token
      final response = await sendRequest(
        route: "/api/auth/login",
        method: RequestMethods.POST,
        load: {
          "email": email,
          "password": password1,
          "device_name": deviceName,
          "fcm_token": fcmToken ?? '',
        },
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt("user_id", response['user']['id']);
      await prefs.setString("token", response['user']['token']);

      userId = response['user']['id'];
      token = response['user']['token'];
      password = password1;

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

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt("user_id", response['user']['id']);
      await prefs.setString("token", response['user']['token']);

      userId = response['user']['id'];
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

  Future logout() async {
    try {
      await sendRequest(
        method: RequestMethods.POST,
        route: "/api/user/logout",
      );
    } catch (_) {}

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    userId = null;
    token = null;
    password = null;
    notifyListeners();
  }

  Future<bool> checkTokenValidity() async {
    final response = await sendRequest(
      method: RequestMethods.GET,
      route: "/api/user/check-token",
    );

    if (response.containsKey('status') && response['status'] == 'success') {
      await refreshToken();
      return true;
    } else {
      return false;
    }
  }

  Future refreshToken() async {
    final response = await sendRequest(
      method: RequestMethods.POST,
      route: "/api/user/refresh",
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", response['user']['token']);

    token = response['user']['token'];
    notifyListeners();
  }

  void updatePassword(String newPassword) {
    password = newPassword;
    notifyListeners();
  }
}
