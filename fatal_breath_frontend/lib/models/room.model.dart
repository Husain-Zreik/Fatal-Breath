class Room {
  final int id;
  final int houseId;
  final String type;
  final String name;
  final bool hasSensor;

  Room({
    required this.id,
    required this.houseId,
    required this.type,
    required this.name,
    required this.hasSensor,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      houseId: json['house_id'],
      type: json['type'],
      name: json['name'],
      hasSensor: json['hasSensor'],
    );
  }
}
