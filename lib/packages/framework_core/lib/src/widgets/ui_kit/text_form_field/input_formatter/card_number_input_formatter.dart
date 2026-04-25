import 'package:flutter/services.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  static const int maxDigits = 16;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // فقط رقم نگه داریم
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // محدود به ۱۶ رقم
    if (digits.length > maxDigits) {
      digits = digits.substring(0, maxDigits);
    }

    final formatted = _groupEvery4(digits);

    // فعلاً کرسر را انتهای متن می‌گذاریم (برای بیشتر سناریوها اوکی است)
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _groupEvery4(String value) {
    final buffer = StringBuffer();
    for (int i = 0; i < value.length; i++) {
      buffer.write(value[i]);
      if ((i + 1) % 4 == 0 && i + 1 != value.length) {
        buffer.write(' ');
      }
    }
    return buffer.toString();
  }

  /// ✅ اعتبارسنجی Luhn (چک‌دیجیت کارت بانکی)
  bool isValidCard(String input) {
    final digits = input.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length != maxDigits) return false;

    int sum = 0;
    bool shouldDouble = false;

    // از راست به چپ
    for (int i = digits.length - 1; i >= 0; i--) {
      int d = int.parse(digits[i]);
      if (shouldDouble) {
        d *= 2;
        if (d > 9) d -= 9;
      }
      sum += d;
      shouldDouble = !shouldDouble;
    }

    return sum % 10 == 0;
  }
}
