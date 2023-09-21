import 'package:fatal_breath_frontend/models/sensor.model.dart';

class Room {
  final int id;
  final int houseId;
  final String type;
  final String name;
  final bool hasSensor;
  final Sensor? sensor;

  Room({
    required this.id,
    required this.houseId,
    required this.type,
    required this.name,
    required this.hasSensor,
    this.sensor,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    final sensorJson = json['sensor'];

    Sensor? roomSensor;

    if (sensorJson != null) {
      roomSensor = Sensor.fromJson(sensorJson);
    }

    return Room(
      id: json['id'],
      houseId: json['house_id'],
      type: json['type'],
      name: json['name'],
      hasSensor: json['hasSensor'],
      sensor: roomSensor,
    );
  }
}
