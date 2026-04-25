import 'package:flutter/services.dart';

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldVal, TextEditingValue newVal) {

    String digits = newVal.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.length > 11) digits = digits.substring(0, 11);

    String formatted = _format(digits);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );
  }

  String _format(String d) {
    final b = StringBuffer();
    for (int i = 0; i < d.length; i++) {
      b.write(d[i]);
      if (i == 3 || i == 6) b.write(" ");
    }
    return b.toString();
  }
}
