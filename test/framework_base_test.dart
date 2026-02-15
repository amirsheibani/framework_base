import 'package:flutter_test/flutter_test.dart';

import 'package:framework_base/framework_base.dart';

void main() {
  test('package exports core types', () {
    expect(Success<int>(data: 1), isA<Result<int>>());
    expect(Failure<int>(message: 'x'), isA<Result<int>>());
    expect(Pagination(page: 1), isNotNull);
    expect(
      DevEnvironment(
        baseUrl: 'https://a.com',
        apiVersion: '',
        mapToken: '',
        appId: '',
        showRuntimeLog: false,
        showChucker: false,
        showPrettyLog: false,
        supabaseUrl: '',
        supabaseAnonKey: '',
      ).url,
      'https://a.com',
    );
  });
}
