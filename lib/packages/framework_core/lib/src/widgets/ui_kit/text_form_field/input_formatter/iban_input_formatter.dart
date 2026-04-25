import 'package:flutter/services.dart';

class IBANInputFormatter extends TextInputFormatter {
  static const int maxDigits = 24;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {

    // متن جدید بدون فاصله
    String clean = newValue.text.replaceAll(" ", "").toUpperCase();

    // IR حذف شود حتی اگر کاربر paste کرد
    clean = clean.replaceAll("IR", "");

    // فقط عدد
    clean = clean.replaceAll(RegExp(r'[^0-9]'), '');

    // محدودیت ۲۴ رقم
    if (clean.length > maxDigits) {
      clean = clean.substring(0, maxDigits);
    }

    // فرمت گروه‌بندی
    final formatted = _formatGroups(clean);

    // محاسبه موقعیت جدید کرسر
    int cursorPos = formatted.length;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursorPos),
    );
  }

  String _formatGroups(String v) {
    final b = StringBuffer();
    for (int i = 0; i < v.length; i++) {
      b.write(v[i]);
      if ((i + 1) % 4 == 0 && i + 1 != v.length) b.write(" ");
    }
    return b.toString();
  }
}
