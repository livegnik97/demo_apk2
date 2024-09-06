import 'package:demo_apk/data/models/user_model.dart';
import 'package:demo_apk/domain/entities/user.dart';

extension UserMapper on User {
  UserModel toModel() => UserModel(
        pk: id,
        username: username,
        name: name,
        movil: movil,
        ci: ci,
      );
}

extension UserModelMapper on UserModel {
  User toEntity() => User(
        id: pk,
        username: username,
        name: name,
        movil: movil,
        ci: ci,
      );
}
