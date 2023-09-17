// ignore_for_file: avoid_print, unused_local_variable

import 'dart:io';

import 'package:fatal_breath_frontend/config/remote.config.dart';
import 'package:fatal_breath_frontend/enums/request.methods.dart';
import 'package:fatal_breath_frontend/models/house.model.dart';
import 'package:fatal_breath_frontend/models/user.model.dart';
import 'package:flutter/material.dart';

class HouseProvider with ChangeNotifier {
  List? adminHouses;
  List? members;

  List? get getHouses {
    return adminHouses;
  }

  List? get getMembers {
    return members;
  }

  Future createHouse(name, country, city, context) async {
    try {
      final body = {
        'name': name,
        'city': city,
        'country': country,
      };
      final response = await sendRequest(
          route: "/api/user/admin/add-house",
          method: RequestMethods.POST,
          load: body);

      await getAdminHouses();

      notifyListeners();
    } catch (e) {
      throw HttpException('$e');
    }
  }

  Future getAdminHouses() async {
    try {
      final response = await sendRequest(
        route: "/api/user/admin/get-houses",
        method: RequestMethods.GET,
      );

      final List<dynamic> houseList = response['houses'];
      List<House> houses = [];

      for (var houseData in houseList) {
        House house = House.fromJson(houseData);
        houses.add(house);
      }

      List<User> allMembers = [];

      if (houses.isNotEmpty) {
        for (var house in houses) {
          if (house.members != null) {
            allMembers.addAll(house.members!);
          }
        }
      }

      adminHouses = houses;
      members = allMembers;

      notifyListeners();
    } catch (e) {
      throw HttpException('$e');
    }
  }

  Future removeMember(houseId, userId, context) async {
    try {
      final response = await sendRequest(
        route: "/api/user/admin/remove-member/$houseId/$userId",
        method: RequestMethods.DELETE,
      );

      await getAdminHouses();

      notifyListeners();
    } catch (e) {
      throw HttpException('$e');
    }
  }

  Future processRequest(houseId, userId, status, context) async {
    try {
      final body = {
        'user_id': userId,
        'house_id': houseId,
        'status': status,
      };
      final response = await sendRequest(
          route: "/api/user/admin/process-request",
          method: RequestMethods.POST,
          load: body);

      await getAdminHouses();

      notifyListeners();
    } catch (e) {
      throw HttpException('$e');
    }
  }

  Future toggleInvite(houseId, userId, context) async {
    try {
      final body = {
        'user_id': userId,
        'house_id': houseId,
      };
      final response = await sendRequest(
          route: "/api/user/admin/toggle-invitation",
          method: RequestMethods.POST,
          load: body);

      await getAdminHouses();

      notifyListeners();
    } catch (e) {
      throw HttpException('$e');
    }
  }
}
