import 'package:flutter_test/flutter_test.dart';
import 'package:framework_base/framework_base.dart';

void main() {
  group('intExtension', () {
    group('toBool', () {
      test('positive returns true', () {
        expect(1.toBool(), true);
        expect(100.toBool(), true);
      });
      test('zero returns false', () {
        expect(0.toBool(), false);
      });
    });

    group('numberFormat', () {
      test('formats with comma separator', () {
        expect(1000.numberFormat(), '1,000');
        expect(1234567.numberFormat(), '1,234,567');
      });
      test('zero', () {
        expect(0.numberFormat(), '0');
      });
    });

    group('toTwoDigit', () {
      test('single digit gets leading zero', () {
        expect(5.toTwoDigit, '05');
        expect(9.toTwoDigit, '09');
      });
      test('two digits unchanged', () {
        expect(10.toTwoDigit, '10');
        expect(99.toTwoDigit, '99');
      });
    });

    group('toCurrencyString', () {
      test('zero returns empty string', () {
        expect(0.toCurrencyString, '');
      });
      test('non-zero returns string of number', () {
        expect(42.toCurrencyString, '42');
      });
    });
  });

  group('PersianOrdinalExtension', () {
    group('toPersianOrdinal', () {
      test('1 to 31 returns Persian ordinal', () {
        expect(1.toPersianOrdinal(), 'یکم');
        expect(2.toPersianOrdinal(), 'دوم');
        expect(10.toPersianOrdinal(), 'دهم');
        expect(31.toPersianOrdinal(), 'سی و یکم');
      });
      test('out of range returns toString', () {
        expect(0.toPersianOrdinal(), '0');
        expect(32.toPersianOrdinal(), '32');
      });
    });

    group('toPersianRank', () {
      test('1 to 10 returns rank', () {
        expect(1.toPersianRank(), 'اول');
        expect(2.toPersianRank(), 'دوم');
        expect(10.toPersianRank(), 'دهم');
      });
      test('out of range returns toString', () {
        expect(11.toPersianRank(), '11');
      });
    });
  });
}
