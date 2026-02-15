import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

import 'package:framework_base/packages/framework_handler/lib/src/service/internet_service_handler.dart';

class _MockConnectivity extends Mock implements Connectivity {}

class _MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  setUpAll(() {
    registerFallbackValue(<ConnectivityResult>[]);
  });

  test('InternetService emits (hasConnection, lastConnectivityResult)', () async {
    final connectivity = _MockConnectivity();
    final internetChecker = _MockInternetConnectionChecker();

    final controller = StreamController<List<ConnectivityResult>>.broadcast();
    when(() => connectivity.onConnectivityChanged)
        .thenAnswer((_) => controller.stream);

    when(() => internetChecker.hasConnection).thenAnswer((_) async => true);

    final service = InternetService(
      connectivity: connectivity,
      internetChecker: internetChecker,
    );

    final emitted = <(bool, ConnectivityResult)>[];
    final sub = service.internetStatus.listen(emitted.add);

    controller.add([ConnectivityResult.wifi, ConnectivityResult.mobile]);

    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(emitted, hasLength(1));
    expect(emitted.first.$1, true);
    expect(emitted.first.$2, ConnectivityResult.mobile);

    await sub.cancel();
    service.dispose();
    await controller.close();
  });

  test('InternetService emits ConnectivityResult.none when list is empty',
      () async {
    final connectivity = _MockConnectivity();
    final internetChecker = _MockInternetConnectionChecker();

    final controller = StreamController<List<ConnectivityResult>>.broadcast();
    when(() => connectivity.onConnectivityChanged)
        .thenAnswer((_) => controller.stream);

    when(() => internetChecker.hasConnection).thenAnswer((_) async => false);

    final service = InternetService(
      connectivity: connectivity,
      internetChecker: internetChecker,
    );

    final emitted = <(bool, ConnectivityResult)>[];
    final sub = service.internetStatus.listen(emitted.add);

    controller.add([]);

    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(emitted, hasLength(1));
    expect(emitted.first.$1, false);
    expect(emitted.first.$2, ConnectivityResult.none);

    await sub.cancel();
    service.dispose();
    await controller.close();
  });
}
