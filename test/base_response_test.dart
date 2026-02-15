import 'package:flutter_test/flutter_test.dart';
import 'package:framework_base/framework_base.dart';

void main() {
  group('BaseResponse', () {
    test('fromJson parses status and message', () {
      final r = BaseResponse.fromJson({
        'status': 200,
        'message': 'OK',
      });
      expect(r.status, 200);
      expect(r.message, 'OK');
    });

    test('fromJson handles null values', () {
      final r = BaseResponse.fromJson({});
      expect(r.status, null);
      expect(r.message, null);
    });
  });

  group('BaseSingleResponseWithoutDataJson', () {
    test('fromJson parses and keeps data as-is with create callback', () {
      final r = BaseSingleResponseWithoutDataJson<String>.fromJson(
        {'status': 200, 'message': 'Done', 'data': 'hello'},
        (d) => d as String,
      );
      expect(r.status, 200);
      expect(r.message, 'Done');
      expect(r.data, 'hello');
    });

    test('fromJson with int data', () {
      final r = BaseSingleResponseWithoutDataJson<int>.fromJson(
        {'status': 201, 'message': 'Created', 'data': 42},
        (d) => d as int,
      );
      expect(r.data, 42);
    });
  });

  group('BaseListResponseWithPages', () {
    test('fromJson parses items with create and sets any', () {
      final r = BaseListResponseWithPages<Map<String, dynamic>, void>.fromJson(
        {
          'status': 200,
          'message': 'OK',
          'items': [
            {'id': 1, 'name': 'a'},
            {'id': 2, 'name': 'b'},
          ],
        },
        (v) => Map<String, dynamic>.from(v as Map),
        'meta',
      );
      expect(r.status, 200);
      expect(r.message, 'OK');
      expect(r.data?.length, 2);
      expect(r.data?[0]['id'], 1);
      expect(r.data?[0]['name'], 'a');
      expect(r.any, 'meta');
    });
  });
}
