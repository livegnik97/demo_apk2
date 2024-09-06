import 'package:demo_apk/data/datasources/usecases/accounts_api.dart';
import 'package:demo_apk/data/dio/my_dio.dart';
import 'package:demo_apk/domain/repositories/remote/remote_repository.dart';
import 'package:demo_apk/domain/repositories/remote/usecases/accounts_remote_repository.dart';

class ApiConsumer extends RemoteRepository {
  late MyDio _myDio;

  //* usecases
  late AccountsApi _accountsApi;

  ApiConsumer() {
    _myDio = MyDio();

    //* usecases
    _accountsApi = AccountsApi(_myDio);
  }

  @override
  AccountsRemoteRepository get accounts => _accountsApi;
}
