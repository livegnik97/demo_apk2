import 'dart:convert';

class User {
  int id;
  String username;
  String name;
  String movil;
  String ci;
  User({
    required this.id,
    required this.username,
    required this.name,
    required this.movil,
    required this.ci,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
      other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }

  User copyWith({
    int? id,
    String? username,
    String? name,
    String? lastName,
    String? image,
    double? ospPoint,
    String? movil,
    String? ci,
    String? userType,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      movil: movil ?? this.movil,
      ci: ci ?? this.ci,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'movil': movil,
      'ci': ci,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      username: map['username'] ?? '',
      name: map['name'] ?? '',
      movil: map['movil'] ?? '',
      ci: map['ci'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
