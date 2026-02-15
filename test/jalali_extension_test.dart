import 'package:flutter_test/flutter_test.dart';
import 'package:framework_base/framework_base.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

void main() {
  group('JalaliExt', () {
    test('expDate returns yy/mm format', () {
      final j = Jalali(1403, 5, 1); // 1403/05/01 -> 03/05
      expect(j.expDate, '03/05');
    });

    test('toDatePersianString returns yyyy/mm/dd with two-digit month and day', () {
      final j = Jalali(1403, 1, 15);
      expect(j.toDatePersianString, '1403/01/15');
    });

    test('montDays returns list 1 to monthLength', () {
      final j = Jalali(1403, 1, 1); // 31 days in month 1
      final days = j.montDays;
      expect(days.length, 31);
      expect(days.first, 1);
      expect(days.last, 31);
    });

    test('months returns map of 12 month names', () {
      final j = Jalali(1403, 6, 1);
      final months = j.months;
      expect(months.length, 12);
      expect(months[1], isNotEmpty);
      expect(months[12], isNotEmpty);
    });

    test('toTwoDigit used in expDate for single digit month', () {
      final j = Jalali(1403, 9, 9);
      expect(j.expDate, '03/09');
    });
  });
}
