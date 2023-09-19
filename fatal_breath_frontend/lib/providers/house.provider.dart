// ignore_for_file: avoid_print, unused_local_variable

import 'dart:io';

import 'package:fatal_breath_frontend/config/local.storage.config.dart';
import 'package:fatal_breath_frontend/config/remote.config.dart';
import 'package:fatal_breath_frontend/enums/local.types.dart';
import 'package:fatal_breath_frontend/enums/request.methods.dart';
import 'package:fatal_breath_frontend/models/house.model.dart';
import 'package:fatal_breath_frontend/models/user.model.dart';
import 'package:fatal_breath_frontend/providers/user.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HouseProvider with ChangeNotifier {
  List? _houses;
  List? members;
  List? invitations;

  List? get getHouses {
    return _houses;
  }

  List? get getInvitations {
    return invitations;
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

      Map<int, User> allMembersMap = {};

      if (houses.isNotEmpty) {
        for (var house in houses) {
          if (house.members != null) {
            for (var member in house.members!) {
              allMembersMap[member.id] = member;
            }
          }
        }
      }

      List<User> allMembers = allMembersMap.values.toList();

      _houses = houses;
      members = allMembers;

      notifyListeners();
    } catch (e) {
      throw HttpException('$e');
    }
  }

  Future getUserHouses() async {
    try {
      final response = await sendRequest(
        route: "/api/user/member/get-houses",
        method: RequestMethods.GET,
      );

      final List<dynamic> houseList = response['houses'];
      List<House> houses = [];

      final List<dynamic> invitedHouseList = response['invitations'];
      List<House> invitedHouses = [];

      for (var invitedHouseData in invitedHouseList) {
        House invitedHouse = House.fromJson(invitedHouseData);
        invitedHouses.add(invitedHouse);
      }

      for (var houseData in houseList) {
        House house = House.fromJson(houseData);
        houses.add(house);
      }
      final currentUserId =
          await getLocal(type: LocalTypes.Int, key: "user_id");

      Map<int, User> allMembersMap = {};

      if (houses.isNotEmpty) {
        for (var house in houses) {
          if (house.members != null) {
            for (var member in house.members!) {
              if (member.id != currentUserId) {
                allMembersMap[member.id] = member;
              }
            }
          }
          if (house.owner != null && house.owner!.id != currentUserId) {
            allMembersMap[house.owner!.id] = house.owner!;
          }
        }
      }

      List<User> allMembers = allMembersMap.values.toList();

      invitations = invitedHouses;
      _houses = houses;
      members = allMembers;

      notifyListeners();
    } catch (e) {
      throw HttpException('$e');
    }
  }

  Future removeMember(houseId, userId, context) async {
    try {
      final response = await sendRequest(
        route: "/api/user/remove-member/$houseId/$userId",
        method: RequestMethods.DELETE,
      );
      final user =
          Provider.of<UserProvider>(context, listen: false).getCurrentUser;

      if (user!.role == 1) {
        await getAdminHouses();
      } else {
        await getUserHouses();
      }

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

  Future processInvitation(houseId, userId, status, context) async {
    try {
      final body = {
        'user_id': userId,
        'house_id': houseId,
        'status': status,
      };
      final response = await sendRequest(
          route: "/api/user/member/process-invitation",
          method: RequestMethods.POST,
          load: body);

      await getUserHouses();

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

  Future toggleRequest(houseId, userId, context) async {
    try {
      final body = {
        'user_id': userId,
        'house_id': houseId,
      };
      final response = await sendRequest(
          route: "/api/user/member/toggle-request",
          method: RequestMethods.POST,
          load: body);

      await getUserHouses();

      notifyListeners();
    } catch (e) {
      throw HttpException('$e');
    }
  }
}
