class Sensor {
  final int id;
  final int roomId;
  final int coLevel;
  final String? createdAt;
  final String? updatedAt;

  Sensor({
    required this.id,
    required this.roomId,
    required this.coLevel,
    this.createdAt,
    this.updatedAt,
  });

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
      id: json['id'],
      roomId: json['room_id'],
      coLevel: json['co_level'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
