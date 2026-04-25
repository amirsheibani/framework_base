import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final bool isRial;

  CurrencyInputFormatter({required this.isRial});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {

    // اگر کاربر چیزی رو کامل پاک کرد
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String newText = newValue.text;

    newText = _toEnglishDigits(newText);

    // فقط عدد و نقطه
    newText = newText.replaceAll(RegExp(r'[^0-9.]'), '');

    // کنترل اعشار
    if (isRial) {
      newText = newText.replaceAll('.', '');
    } else {
      final parts = newText.split('.');

      if (parts.length > 1) {
        String integer = parts[0];
        String decimal = parts.sublist(1).join();

        if (decimal.length > 2) {
          decimal = decimal.substring(0, 2);
        }

        newText = "$integer.$decimal";
      }
    }

    // جدا کردن صحیح و اعشار
    String integerPart = newText;
    String decimalPart = "";

    if (!isRial && newText.contains('.')) {
      final split = newText.split('.');
      integerPart = split[0];
      decimalPart = split.length > 1 ? split[1] : "";
    }

    final formattedInteger = _formatThousands(integerPart);

    String formattedText = formattedInteger;

    if (!isRial && newText.contains('.')) {
      formattedText = "$formattedInteger.$decimalPart";
    }

    // ✅ محاسبه صحیح موقعیت کرسر
    int baseOffset = newValue.selection.baseOffset;
    int diff = formattedText.length - newValue.text.length;
    int newOffset = baseOffset + diff;

    if (newOffset < 0) newOffset = 0;
    if (newOffset > formattedText.length) {
      newOffset = formattedText.length;
    }
    if (isRial) {
      formattedText = _toPersianDigits(formattedText);
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }

  String _formatThousands(String value) {
    if (value.isEmpty) return '';

    final chars = value.split('').reversed.toList();
    final buffer = StringBuffer();

    for (int i = 0; i < chars.length; i++) {
      if (i != 0 && i % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(chars[i]);
    }

    return buffer.toString().split('').reversed.join();
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
String _toPersianDigits(String input) {
  const english = ['0','1','2','3','4','5','6','7','8','9'];
  const persian = ['۰','۱','۲','۳','۴','۵','۶','۷','۸','۹'];

  for (int i = 0; i < 10; i++) {
    input = input.replaceAll(english[i], persian[i]);
  }

  return input;
}
