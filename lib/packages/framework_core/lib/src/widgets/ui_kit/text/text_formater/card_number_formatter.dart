extension OnformatCardNumber on String{
   String get formatCardNumber {
    String digits = replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.length > 16) {
      digits = digits.substring(0, 16);
    }

    final buffer = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);

      if ((i + 1) % 4 == 0 && i + 1 != digits.length) {
        buffer.write(' ');
      }
    }

    return buffer.toString();
  }
}