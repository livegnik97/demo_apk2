import 'package:demo_apk/data/datasources/api.dart';
import 'package:demo_apk/domain/repositories/remote/remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiProvider = Provider<RemoteRepository>((ref) {
    return ApiConsumer();
  }
);