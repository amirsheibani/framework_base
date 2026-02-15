import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:framework_base/framework_base.dart';

void main() {
  group('StreamDebounce', () {
    test('emits only last value after debounce duration', () async {
      final c = StreamController<String>();
      final stream = c.stream.debounce(const Duration(milliseconds: 50));
      final results = <String>[];
      stream.listen(results.add);

      c.add('a');
      c.add('b');
      c.add('c');
      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(results.length, 1);
      expect(results.single, 'c');

      await c.close();
    });

    test('multiple bursts each emit last value of burst', () async {
      final c = StreamController<String>();
      final stream = c.stream.debounce(const Duration(milliseconds: 30));
      final results = <String>[];
      stream.listen(results.add);

      c.add('x');
      await Future<void>.delayed(const Duration(milliseconds: 50));
      c.add('y');
      c.add('z');
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(results.length, 2);
      expect(results[0], 'x');
      expect(results[1], 'z');

      await c.close();
    });
  });
}
