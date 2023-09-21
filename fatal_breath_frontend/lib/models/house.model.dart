import 'package:fatal_breath_frontend/models/room.model.dart';
import 'package:fatal_breath_frontend/models/user.model.dart';

class House {
  final int id;
  final String name;
  final int ownerId;
  final User? owner;
  final String city;
  final String country;
  final List<Room>? rooms;
  final List<User>? members;
  final List<User>? requests;
  final bool? isRequested;

  House({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.city,
    required this.country,
    this.owner,
    this.isRequested,
    this.rooms,
    this.members,
    this.requests,
  });

  factory House.fromJson(Map<String, dynamic> json) {
    final ownerJson = json['owner'];
    final owner = ownerJson != null ? User.fromJson(ownerJson) : null;

    List<Room>? rooms;
    if (json['rooms'] != null && json['rooms'].isNotEmpty) {
      rooms = (json['rooms'] as List<dynamic>)
          .map((roomJson) => Room.fromJson(roomJson))
          .toList();
    }

    List<User>? members;
    if (json['members'] != null && json['members'].isNotEmpty) {
      members = (json['members'] as List<dynamic>)
          .map((memberJson) => User.fromJson(memberJson))
          .toList();
    }

    List<User>? requests;
    if (json['requests'] != null && json['requests'].isNotEmpty) {
      requests = (json['requests'] as List<dynamic>).map((requestJson) {
        final userJson = requestJson['user'];
        final user = User.fromJson(userJson);
        return user;
      }).toList();
    }

    return House(
      id: json['id'],
      name: json['name'],
      ownerId: json['owner_id'],
      city: json['city'],
      country: json['country'],
      isRequested: json['isRequested'],
      owner: owner,
      rooms: rooms,
      members: members,
      requests: requests,
    );
  }
}
