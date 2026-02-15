import 'package:flutter_test/flutter_test.dart';
import 'package:framework_base/framework_base.dart';

void main() {
  group('Result', () {
    group('Success', () {
      test('holds data, optional message and meta', () {
        const r = Success<int>(data: 42, message: 'ok', meta: null);
        expect(r.data, 42);
        expect(r.message, 'ok');
        expect(r.meta, null);
      });

      test('can have only data', () {
        const r = Success<String>(data: 'hello');
        expect(r.data, 'hello');
        expect(r.message, null);
        expect(r.meta, null);
      });

      test('is Result subtype', () {
        const Result<int> r = Success<int>(data: 1);
        expect(r, isA<Success<int>>());
      });
    });

    group('Failure', () {
      test('holds message and optional meta', () {
        const r = Failure<int>(message: 'error', meta: 404);
        expect(r.message, 'error');
        expect(r.meta, 404);
      });

      test('can have only message', () {
        const r = Failure<bool>(message: 'failed');
        expect(r.message, 'failed');
        expect(r.meta, null);
      });

      test('is Result subtype', () {
        const Result<void> r = Failure<void>(message: 'err');
        expect(r, isA<Failure<void>>());
      });
    });

    group('pattern matching (switch)', () {
      test('Success branch', () {
        Result<int> result = const Success<int>(data: 10);
        int value = 0;
        switch (result) {
          case Success(data: final d, message: _, meta: _):
            value = d ?? 0;
          case Failure(message: _, meta: _):
            value = -1;
        }
        expect(value, 10);
      });

      test('Failure branch', () {
        Result<int> result = const Failure<int>(message: 'err');
        int value = 0;
        switch (result) {
          case Success(data: final d, message: _, meta: _):
            value = d ?? 0;
          case Failure(message: final m, meta: _):
            value = -1;
        }
        expect(value, -1);
      });
    });
  });
}
