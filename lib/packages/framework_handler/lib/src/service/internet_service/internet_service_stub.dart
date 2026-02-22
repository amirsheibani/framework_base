import 'package:connectivity_plus/connectivity_plus.dart';
import 'internet_service.dart';

class InternetServiceImpl implements InternetService {
  @override
  Stream<(bool, ConnectivityResult)> get internetStatus =>
      const Stream<(bool, ConnectivityResult)>.empty();

  @override
  Future<(bool, ConnectivityResult)> checkNow() async =>
      (false, ConnectivityResult.none);

  @override
  void dispose() {}
}