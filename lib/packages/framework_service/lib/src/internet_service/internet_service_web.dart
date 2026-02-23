import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'internet_service.dart';

class InternetServiceImpl implements InternetService {
  final Connectivity _connectivity = Connectivity();

  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  final _controller =
  StreamController<(bool, ConnectivityResult)>.broadcast();

  @override
  Stream<(bool, ConnectivityResult)> get internetStatus =>
      _controller.stream;

  InternetServiceImpl() {
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      final connectivityResult =
          results.isNotEmpty ? results.last : ConnectivityResult.none;

      final hasConnection = connectivityResult != ConnectivityResult.none;
      _controller.add((hasConnection, connectivityResult));
    });
  }

  @override
  Future<(bool, ConnectivityResult)> checkNow() async {
    final results = await _connectivity.checkConnectivity();

    final connectivityResult =
        results.isNotEmpty ? results.last : ConnectivityResult.none;

    return (connectivityResult != ConnectivityResult.none, connectivityResult);
  }

  @override
  void dispose() {
    _subscription.cancel();
    _controller.close();
  }
}