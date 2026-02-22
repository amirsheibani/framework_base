import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'internet_service.dart';

class InternetServiceImpl implements InternetService {
  final Connectivity _connectivity = Connectivity();
  final InternetConnectionChecker _checker = InternetConnectionChecker();

  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  final _controller =
  StreamController<(bool, ConnectivityResult)>.broadcast();

  @override
  Stream<(bool, ConnectivityResult)> get internetStatus =>
      _controller.stream;

  InternetServiceImpl() {
    _subscription = _connectivity.onConnectivityChanged.listen((results) async {
      final hasInternet = await _checker.hasConnection;

      final connectivityResult =
          results.isNotEmpty ? results.last : ConnectivityResult.none;

      _controller.add((hasInternet, connectivityResult));
    });
  }

  @override
  Future<(bool, ConnectivityResult)> checkNow() async {
    final results = await _connectivity.checkConnectivity();
    final hasInternet = await _checker.hasConnection;

    final connectivityResult =
        results.isNotEmpty ? results.last : ConnectivityResult.none;

    return (hasInternet, connectivityResult);
  }

  @override
  void dispose() {
    _subscription.cancel();
    _controller.close();
  }
}