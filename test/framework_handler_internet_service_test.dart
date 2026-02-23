import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:framework_base/packages/framework_service/lib/src/internet_service/internet_service_stub.dart';

void main() {
  test('InternetServiceImpl stub returns no internet by default', () async {
    final service = InternetServiceImpl();

    final status = await service.checkNow();
    expect(status.$1, false);
    expect(status.$2, ConnectivityResult.none);

    service.dispose();
  });
}
