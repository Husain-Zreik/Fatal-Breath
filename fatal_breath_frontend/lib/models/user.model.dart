class User {
  final int id;
  final int role;
  final String username;
  final String name;
  final String email;
  final String? profileImage;
  final bool? isInvited;

  User({
    required this.id,
    required this.role,
    required this.username,
    required this.name,
    required this.email,
    this.profileImage,
    this.isInvited,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      role: json['role'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profile_image'],
      isInvited: json['isInvited'],
    );
  }
}
