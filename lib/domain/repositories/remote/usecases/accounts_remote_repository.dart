import 'package:demo_apk/domain/entities/user.dart';

abstract class AccountsRemoteRepository {
  Future<dynamic> login(
      {required String usernameXemail,
      required String password,
      required Function(String? accessToken, String? refreshToken, User? user)
          loginCallback});

  Future<dynamic> tokenRefresh(String? refreshToken,
      Function(String? accessToken, String? refreshToken) callback);

  Future<dynamic> tokenVerify(String accessToken);

  Future<dynamic> changePassword(String oldPassword, String newPassword);

  Future<dynamic> resetPassword(String email);

  Future<dynamic> resetPasswordConfirm(
      {required String uid,
      required String token,
      required String new_password});
}
