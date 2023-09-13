import 'package:fatal_breath_frontend/models/room.model.dart';
import 'package:fatal_breath_frontend/models/user.model.dart';

class House {
  final int id;
  final String name;
  final int ownerId;
  final String city;
  final String country;
  final List<Room>? rooms;
  final List<User>? members;

  House({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.city,
    required this.country,
    this.rooms,
    this.members,
  });

  factory House.fromJson(Map<String, dynamic> json) {
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

    return House(
      id: json['id'],
      name: json['name'],
      ownerId: json['owner_id'],
      city: json['city'],
      country: json['country'],
      rooms: rooms,
      members: members,
    );
  }
}
