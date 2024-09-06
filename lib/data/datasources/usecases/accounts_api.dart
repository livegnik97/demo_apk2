import 'package:demo_apk/data/dio/my_dio.dart';
import 'package:demo_apk/data/mappers/user_mapper.dart';
import 'package:demo_apk/data/models/user_model.dart';
import 'package:demo_apk/domain/entities/user.dart';
import 'package:demo_apk/domain/repositories/remote/usecases/accounts_remote_repository.dart';

class AccountsApi extends AccountsRemoteRepository {
  final MyDio _myDio;
  AccountsApi(this._myDio);

  final String localUrl = "accounts";

  @override
  Future<void> login(
      {required String usernameXemail,
      required String password,
      required Function(String? accessToken, String? refreshToken, User? user)
          loginCallback}) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/login/',
          requestType: RequestType.POST,
          data: {
            if (!usernameXemail.contains("@")) 'username': usernameXemail,
            if (usernameXemail.contains("@")) 'email': usernameXemail,
            'password': password
          });
      String? accessToken = json["access"];
      String? refreshToken = json["refresh"];
      Map<String, dynamic>? user = json["user"];
      loginCallback(accessToken, refreshToken,
          user == null ? null : UserModel.fromMap(user).toEntity());
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<dynamic> tokenRefresh(String? refreshToken,
      Function(String? accessToken, String? refreshToken) callback) async {
    try {
      final json = await _myDio.request(
          path: '$localUrl/token/refresh/',
          requestType: RequestType.POST,
          data: {'refresh': refreshToken});
      String? accessToken = json["access"];
      String? refreshTokenNew = json["refresh"];
      if (accessToken != null) _myDio.updateToken(accessToken);
      callback(accessToken, refreshTokenNew);
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future<dynamic> tokenVerify(String accessToken) async {
    try {
      await _myDio.request(
          path: '$localUrl/token/verify/',
          requestType: RequestType.POST,
          data: {'token': accessToken});
      _myDio.updateToken(accessToken);
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future changePassword(String oldPassword, String newPassword) async {
    try {
      await _myDio.request(
          path: '$localUrl/password/change/',
          requestType: RequestType.POST,
          requiredResponse: false,
          data: {'new_password1': oldPassword, 'new_password2': newPassword});
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future resetPassword(String email) async {
    try {
      await _myDio.request(
          path: '$localUrl/password/reset/',
          requestType: RequestType.POST,
          data: {'email': email});
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }

  @override
  Future resetPasswordConfirm(
      {required String uid,
      required String token,
      required String new_password}) async {
    try {
      await _myDio.request(
          path: '$localUrl/password/reset/confirm/',
          requestType: RequestType.POST,
          requiredResponse: false,
          data: {
            'new_password1': new_password,
            'new_password2': new_password,
            'uid': uid,
            'token': token,
          });
    } on CustomDioError catch (_) {
      rethrow;
    } catch (e) {
      throw CustomDioError(code: 400);
    }
  }
}
