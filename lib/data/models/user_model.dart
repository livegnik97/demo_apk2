import 'dart:convert';

class UserModel {
  int pk;
  String username;
  String name;
  String movil;
  String ci;
  UserModel({
    required this.pk,
    required this.username,
    required this.name,
    required this.movil,
    required this.ci,
  });

  Map<String, dynamic> toMap() {
    return {
      'pk': pk,
      'username': username,
      'name': name,
      'movil': movil,
      'ci': ci,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      pk: map['pk']?.toInt() ?? 0,
      username: map['username'] ?? '',
      name: map['name'] ?? '',
      movil: map['movil'] ?? '',
      ci: map['ci'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
