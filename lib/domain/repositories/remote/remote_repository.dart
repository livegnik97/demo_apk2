

import 'package:demo_apk/domain/repositories/remote/usecases/accounts_remote_repository.dart';

abstract class RemoteRepository {
  AccountsRemoteRepository get accounts;
}