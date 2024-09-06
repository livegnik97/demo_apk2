import 'dart:async';

import 'package:demo_apk/data/dio/my_dio.dart';
import 'package:demo_apk/domain/entities/user.dart';
import 'package:demo_apk/domain/repositories/remote/usecases/accounts_remote_repository.dart';
import 'package:demo_apk/presentation/providers/conectivity/connectivity_status_provider.dart';
import 'package:demo_apk/presentation/providers/data_providers/api_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountProvider =
    StateNotifierProvider<AccountNotifier, AccountState>((ref) {
  final apiConsumer = ref.read(apiProvider);
  final connectivityStatusNotifier =
      ref.read(connectivityStatusProvider.notifier);

  return AccountNotifier(
      accountsRemoteRepository: apiConsumer.accounts,
      connectivityStatusNotifier: connectivityStatusNotifier);
});

class AccountNotifier extends StateNotifier<AccountState> {
  final AccountsRemoteRepository accountsRemoteRepository;
  final ConnectivityStatusNotifier connectivityStatusNotifier;
  Timer? _timerHandle;

  AccountNotifier({
    required this.accountsRemoteRepository,
    required this.connectivityStatusNotifier,
  }) : super(AccountState()) {
    connectivityStatusNotifier.addListener((connectivityStatusState) {
      if (connectivityStatusState.isConnected) {
        //* verificar que el token sea valido
        // _verifyToken();
      } else {
        _cancelTimer();
      }
    });
  }

  void _cancelTimer() async {
    _timerHandle?.cancel();
  }

  void _startTimer(Function() callback) async {
    _cancelTimer();
    //* verifica el token cada 15 minutos
    _timerHandle =
        Timer(const Duration(milliseconds: 1000 * 60 * 15), callback);
  }

  AccountState get currentState => state;

  Future<int> login({
    required String usernameXemail,
    required String password,
  }) async {
    try {
      // if (!connectivityStatusNotifier.isConnected) {
      //   return 498;
      // }

      //* Aquí haría la request al endpoint de loguearse
      // await accountsRemoteRepository.login(
      //     usernameXemail: usernameXemail,
      //     password: password,
      //     loginCallback:
      //         (String? accessToken, String? refreshToken, User? user) {
      //       state = state.copyWith(
      //           accessToken: accessToken,
      //           refreshToken: refreshToken,
      //           isVerifyToken: false,
      //           user: () => user);

      //       _startTimer(() {});
      //     });

      await Future.delayed(const Duration(seconds: 5), () {});
      return 200;
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
      throw CustomDioError(code: 400);
    }
  }

  Future<void> logout() async {
    _cancelTimer();
    state = state.copyWith(accessToken: "", refreshToken: "", user: () => null);
  }

  Future<int> changePassword(String oldPassword, String newPassword) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      await accountsRemoteRepository.changePassword(oldPassword, newPassword);
      return 200;
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
      throw CustomDioError(code: 400);
    }
  }

  Future<int> resetPassword(String email) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      await accountsRemoteRepository.resetPassword(email);
      return 200;
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
      throw CustomDioError(code: 400);
    }
  }

  Future<int> resetPasswordConfirm({
    required String uid,
    required String token,
    required String newPassword,
  }) async {
    try {
      if (!connectivityStatusNotifier.isConnected) {
        return 498;
      }
      await accountsRemoteRepository.resetPasswordConfirm(
          uid: uid, token: token, new_password: newPassword);
      return 200;
    } on CustomDioError catch (_) {
      connectivityStatusNotifier.checkedConnection();
      rethrow;
    } catch (e) {
      connectivityStatusNotifier.checkedConnection();
      throw CustomDioError(code: 400);
    }
  }
}

enum AccountStatus { checking, authenticated, notAuthenticated }

class AccountState {
  final AccountStatus authStatus;
  final String accessToken;
  final String refreshToken;
  final User? user;
  final String errorMessage;
  final int errorCode;
  final bool isVerifyToken;
  final bool changingProfileImage;

  AccountState({
    this.authStatus = AccountStatus.checking,
    this.accessToken = '',
    this.refreshToken = '',
    this.user,
    this.errorMessage = '',
    this.errorCode = 400,
    this.isVerifyToken = false,
    this.changingProfileImage = false,
  });

  bool get isLogin => accessToken.isNotEmpty;
  String get id {
    if (!isLogin) return '';
    if (user != null) {
      return user!.id.toString();
    }
    return '';
  }

  String get username {
    if (!isLogin) return '';
    if (user != null) {
      return user!.username;
    }
    return '';
  }

  String get name {
    if (!isLogin) return '';
    if (user != null) {
      return user!.name;
    }
    return '';
  }

  AccountState copyWith({
    AccountStatus? authStatus,
    String? accessToken,
    String? refreshToken,
    ValueGetter<User?>? user,
    String? errorMessage,
    int? errorCode,
    bool? isVerifyToken,
    bool? changingProfileImage,
  }) {
    return AccountState(
      authStatus: authStatus ?? this.authStatus,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user != null ? user() : this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      errorCode: errorCode ?? this.errorCode,
      isVerifyToken: isVerifyToken ?? this.isVerifyToken,
      changingProfileImage: changingProfileImage ?? this.changingProfileImage,
    );
  }
}
