// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fatal_breath_frontend/config/remote.config.dart';
import 'package:fatal_breath_frontend/enums/request.methods.dart';
import 'package:fatal_breath_frontend/models/house.model.dart';
import 'package:fatal_breath_frontend/models/user.model.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  String? name;
  String? username;
  String? email;
  String? image;
  String? userType;
  User? user;

  List searchList = [];

  User? get getCurrentUser {
    return user;
  }

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

  List? get getSearchList {
    return searchList;
  }

  String? get getImage {
    if (image != null) {
      debugPrint("$baseUrl/storage/$image");
      return "$baseUrl/storage/$image";
    }

    return null;
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
        userType = "Manager";
      } else {
        userType = "User";
      }
      user = User.fromJson(response['user']);

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

      name = response['user']["name"];
      username = response['user']["username"];
      email = response['user']["email"];
      image = response['user']["profile_image"];
      user = User.fromJson(response['user']);

      notifyListeners();
    } catch (error) {
      throw HttpException('$error');
    }
  }

  Future changePassword(currentPassword, newPassword, context) async {
    try {
      await sendRequest(
        route: "/api/user/info/change-password",
        method: RequestMethods.POST,
        load: {
          "current_password": currentPassword,
          "new_password": newPassword,
          "new_password_confirmation": newPassword,
        },
      );

      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          throw const HttpException(
              "Unauthorized. Please log in and try again.");
        } else {
          throw const HttpException("An unexpected error occurred.");
        }
      } else {
        throw HttpException('$e');
      }
    }
  }

  Future usernameSearch(username, houseId, BuildContext context) async {
    try {
      final body = {
        'house_id': houseId,
        'username': username,
      };

      final response = await sendRequest(
        route: "/api/user/admin/search",
        method: RequestMethods.POST,
        load: body,
      );

      if (response.containsKey('users')) {
        final List<dynamic> usersList = response['users'];
        List<User> users = [];

        for (var userData in usersList) {
          User user = User.fromJson(userData);
          users.add(user);
        }

        searchList = users;
        notifyListeners();
      } else {
        return [];
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          throw const HttpException(
              "Unauthorized. Please log in and try again.");
        } else {
          throw const HttpException("An unexpected error occurred.");
        }
      } else {
        throw HttpException('$e');
      }
    }
  }

  Future houseSearch(searchTerm, BuildContext context) async {
    try {
      final body = {
        'search_term': searchTerm,
      };

      final response = await sendRequest(
        route: "/api/user/member/search",
        method: RequestMethods.POST,
        load: body,
      );

      if (response.containsKey('houses')) {
        final List<dynamic> housesList = response['houses'];
        List<House> houses = [];

        for (var houseData in housesList) {
          House house = House.fromJson(houseData);
          houses.add(house);
        }

        searchList = houses;
        notifyListeners();
      } else {
        return [];
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          throw const HttpException(
              "Unauthorized. Please log in and try again.");
        } else {
          throw const HttpException("An unexpected error occurred.");
        }
      } else {
        throw HttpException('$e');
      }
    }
  }

  void clearSearchList() {
    searchList.clear();
    notifyListeners();
  }

  Future getUsers(houseId, context) async {
    try {
      final response = await sendRequest(
        route: "/api/user/admin/$houseId/get-requests-members",
      );

      final data = json.decode(response);

      final List<User> requests = (data['pending_requests'] as List)
          .map((json) => User.fromJson(json['user']))
          .toList();

      final List<User> members = (data['house_members'] as List)
          .map((json) => User.fromJson(json['user']))
          .toList();

      notifyListeners();
    } catch (e) {
      throw HttpException('$e');
    }
  }
}
