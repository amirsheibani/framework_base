import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldVal,
      TextEditingValue newVal,
      ) {
    // 1) تبدیل اعداد فارسی/عربی به انگلیسی
    String text = _toEnglishDigits(newVal.text);

    // 2) فقط عدد نگه دار
    String digits = text.replaceAll(RegExp(r'[^0-9]'), '');

    // حداکثر 8 رقم: yyyyMMdd
    if (digits.length > 8) digits = digits.substring(0, 8);

    // اگر هیچ چیزی نیست
    if (digits.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // 3) کنترل سال (اولین عدد سال نباید 0 باشد)
    if (digits.length >= 1 && digits[0] == '0') {
      // اگر کاربر سال را با 0 شروع کرد، همان مقدار قبلی را نگه داریم
      return oldVal;
    }

    // 4) کنترل ماه (01 تا 12، نه 00 و نه > 12)
    if (digits.length >= 6) {
      int month = int.parse(digits.substring(4, 6));
      if (month < 1) {
        // یعنی 00 → تبدیل به 01
        digits = digits.substring(0, 4) + '01' + digits.substring(6);
      } else if (month > 12) {
        // بالاتر از 12 → تبدیل به 12
        digits = digits.substring(0, 4) + '12' + digits.substring(6);
      }
    }

    // 5) کنترل روز (01 تا 31، نه 00 و نه > 31)
    if (digits.length == 8) {
      int day = int.parse(digits.substring(6, 8));
      if (day < 1) {
        // 00 → 01
        digits = digits.substring(0, 6) + '01';
      } else if (day > 31) {
        // بالاتر از 31 → 31
        digits = digits.substring(0, 6) + '31';
      }
    }

    // 6) ساختن رشته فرمت‌شده yyyy/MM/dd
    final formatted = _format(digits);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _format(String d) {
    if (d.length <= 4) {
      // فقط سال
      return d;
    } else if (d.length <= 6) {
      // سال/ماه
      return '${d.substring(0, 4)}/${d.substring(4)}';
    } else {
      // سال/ماه/روز
      return '${d.substring(0, 4)}/${d.substring(4, 6)}/${d.substring(6)}';
    }
  }

  String _toEnglishDigits(String input) {
    const persian = ['۰','۱','۲','۳','۴','۵','۶','۷','۸','۹'];
    const arabic  = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];

    for (int i = 0; i < 10; i++) {
      input = input.replaceAll(persian[i], '$i');
      input = input.replaceAll(arabic[i], '$i');
    }

    return input;
  }

  bool isValid(String f) {
    final p = f.split('/');
    if (p.length < 3) return false;

    final yearStr  = p[0];
    final monthStr = p[1];
    final dayStr   = p[2];

    // سال، ماه، روز نباید خالی باشند یا همه صفر باشند
    if (yearStr.isEmpty || monthStr.isEmpty || dayStr.isEmpty) return false;
    if (RegExp(r'^0+$').hasMatch(yearStr)) return false;
    if (RegExp(r'^0+$').hasMatch(monthStr)) return false;
    if (RegExp(r'^0+$').hasMatch(dayStr)) return false;

    int y = int.parse(yearStr);
    int m = int.parse(monthStr);
    int d = int.parse(dayStr);

    if (m < 1 || m > 12) return false;

    const days = [31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29];
    if (d < 1 || d > days[m - 1]) return false;

    // اگر سال را هم بخواهی محدوده بدهی، اینجا می‌توانی چک کنی
    // مثلا:
    // if (y < 1300 || y > 1500) return false;

    return true;
  }
}
