class UserEntity {
  final int id;
  final String username;
  final String password;

  UserEntity({
    required this.id,
    required this.username,
    required this.password,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'] ?? 0,
      username: map['username'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
