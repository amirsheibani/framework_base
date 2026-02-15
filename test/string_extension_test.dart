import 'package:flutter_test/flutter_test.dart';
import 'package:framework_base/framework_base.dart';

void main() {
  group('StringExtension', () {
    group('toBool', () {
      test('"true" returns true', () {
        expect('true'.toBool, true);
        expect('TRUE'.toBool, true);
      });
      test('"false" returns false', () {
        expect('false'.toBool, false);
        expect('FALSE'.toBool, false);
      });
      test('null returns false', () {
        expect((null as String?).toBool, false);
      });
      test('other string returns false', () {
        expect('yes'.toBool, false);
        expect('1'.toBool, false);
      });
    });

    group('formatJalaliDate', () {
      test('valid 8-digit string returns formatted yyyy/mm/dd', () {
        expect('14030115'.formatJalaliDate, '1403/01/15');
      });
      test('null returns empty string', () {
        expect((null as String?).formatJalaliDate, '');
      });
      test('invalid length returns empty', () {
        expect('140301'.formatJalaliDate, '');
      });
      test('non-digit returns empty', () {
        expect('1403011a'.formatJalaliDate, '');
      });
    });

    group('hidden', () {
      test('replaces all characters with default *', () {
        expect('hello'.hidden(), '*****');
      });
      test('custom character', () {
        expect('abc'.hidden(character: 'x'), 'xxx');
      });
      test('null returns null', () {
        expect((null as String?).hidden(), null);
      });
    });

    group('titleCase', () {
      test('capitalizes first letter of each word', () {
        expect('hello world'.titleCase, 'Hello World');
      });
      test('null returns null', () {
        expect((null as String?).titleCase, null);
      });
      test('single word', () {
        expect('flutter'.titleCase, 'Flutter');
      });
    });

    group('convertNumberToPersian', () {
      test('converts 0-9 to Persian digits', () {
        expect('0123456789'.convertNumberToPersian, '۰۱۲۳۴۵۶۷۸۹');
      });
      test('null returns null', () {
        expect((null as String?).convertNumberToPersian, null);
      });
    });

    group('convertNumberToEnglish', () {
      test('converts Persian digits to English', () {
        expect('۰۱۲۳۴۵۶۷۸۹'.convertNumberToEnglish, '0123456789');
      });
      test('null returns null', () {
        expect((null as String?).convertNumberToEnglish, null);
      });
    });

    group('normalizePersian', () {
      test('replaces ي with ی and ك with ک and trims', () {
        expect('  متن با ي و ك  '.normalizePersian(), 'متن با ی و ک');
      });
      test('null returns empty string', () {
        expect((null as String?).normalizePersian(), '');
      });
    });

    group('convertPersianDateWithSeparator', () {
      test('8-digit with separator', () {
        expect('14030115'.convertPersianDateWithSeparator('/'), '1403/01/15');
      });
      test('null returns null', () {
        expect((null as String?).convertPersianDateWithSeparator('/'), null);
      });
    });

    group('removeExtraZeroFromDecimal', () {
      test('removes trailing decimal zeros', () {
        expect('123.000'.removeExtraZeroFromDecimal, '123');
      });
      test('null returns null', () {
        expect((null as String?).removeExtraZeroFromDecimal, null);
      });
    });

    group('removeThousandSeperator', () {
      test('removes comma and dot', () {
        expect('1,234.56'.removeThousandSeperator, '123456');
      });
    });

    group('convertSpaceToHalfSpace', () {
      test('replaces underscore with half-space', () {
        expect('a_b'.convertSpaceToHalfSpace, 'a\u200cb');
      });
    });
  });
}
