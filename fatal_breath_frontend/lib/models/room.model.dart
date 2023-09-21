import 'package:fatal_breath_frontend/models/sensor.model.dart';

class Room {
  final int id;
  final int houseId;
  final String type;
  final String name;
  final bool hasSensor;
  final List<Sensor> sensors;

  Room({
    required this.id,
    required this.houseId,
    required this.type,
    required this.name,
    required this.hasSensor,
    required this.sensors,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    final List<Sensor> roomSensors = [];
    final sensorJson = json['sensors'];

    if (sensorJson != null) {
      for (final sensorData in sensorJson) {
        roomSensors.add(Sensor.fromJson(sensorData));
      }
    }

    return Room(
      id: json['id'],
      houseId: json['house_id'],
      type: json['type'],
      name: json['name'],
      hasSensor: json['hasSensor'],
      sensors: roomSensors,
    );
  }
}
