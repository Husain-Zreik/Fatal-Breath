import 'package:fatal_breath_frontend/models/room.model.dart';

class HouseWithRooms {
  final String name;
  final String city;
  final String country;
  final List<Room> rooms;

  HouseWithRooms({
    required this.name,
    required this.city,
    required this.country,
    required this.rooms,
  });
}
