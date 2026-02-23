import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

export 'internet_service_stub.dart'
if (dart.library.html) 'internet_service_web.dart'
if (dart.library.io) 'internet_service_mobile.dart';

import 'internet_service_stub.dart'
    if (dart.library.html) 'internet_service_web.dart'
    if (dart.library.io) 'internet_service_mobile.dart' as _impl;

abstract class InternetService {
  Stream<(bool, ConnectivityResult)> get internetStatus;

  Future<(bool, ConnectivityResult)> checkNow();

  void dispose();
}

@module
abstract class InternetServiceModule {
  @lazySingleton
  InternetService provideInternetService() => _impl.InternetServiceImpl();
}
