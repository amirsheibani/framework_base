extension OnformatIBAN on String{
  String get formatPhone{
    String digits = replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.length > 11) {
      digits = digits.substring(0, 11);
    }

    final b = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      b.write(digits[i]);

      if (i == 3 || i == 6) {
        b.write(" ");
      }
    }

    return b.toString();
  }
}