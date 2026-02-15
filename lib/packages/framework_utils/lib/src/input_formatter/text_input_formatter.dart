import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final VoidCallback? errorHandler;

  CurrencyInputFormatter({this.errorHandler});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (!RegExp(r'^[0-9.,]*$').hasMatch(text)) {
      errorHandler?.call();
      return oldValue;
    }

    if (text.isEmpty) {
      return newValue.copyWith(
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    const separator = ",";
    final parts = text.split(".");
    final integerPart = parts[0].replaceAll(separator, "");

    final buffer = StringBuffer();
    for (int i = 0; i < integerPart.length; i++) {
      final reversedIndex = integerPart.length - i;
      buffer.write(integerPart[i]);
      if (reversedIndex > 1 && reversedIndex % 3 == 1) {
        buffer.write(separator);
      }
    }

    String formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class IbanInputFormatter extends TextInputFormatter {
  final VoidCallback? errorHandler;

  IbanInputFormatter({this.errorHandler});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (RegExp(r'^[IR0-9\s]*$').hasMatch(newValue.text) || newValue.text.isEmpty) {
      if (oldValue.text != newValue.text) {
        final String result = newValue.text;
        return TextEditingValue(text: result, selection: TextSelection.fromPosition(TextPosition(offset: result.length)));
      }
    } else {
      errorHandler?.call();
    }
    return oldValue;
  }
}

class CapitalLetterTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.trim().toString();
    return TextEditingValue(
        selection: newValue.selection,
        text: newText.toUpperCase()
    );
  }
}

class MaxLengthLimitTextInputFormatter extends TextInputFormatter {
  final int lengthLimit;

  MaxLengthLimitTextInputFormatter({required this.lengthLimit});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final oldText = oldValue.text.trim().toString();
    final newText = newValue.text.trim().toString();
    return TextEditingValue(
        selection: newValue.selection,
        text: newText.length > lengthLimit ? oldText : newText
    );
  }
}

class EnglishNumberFormatter extends TextInputFormatter {
  final VoidCallback? errorHandler;

  EnglishNumberFormatter({this.errorHandler});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (RegExp(r'[0-9]').hasMatch(newValue.text) || newValue.text.isEmpty) {
      if (oldValue.text != newValue.text) {
        final String result = newValue.text;
        return TextEditingValue(text: result, selection: TextSelection.fromPosition(TextPosition(offset: result.length)));
      }
    } else {
      errorHandler?.call();
    }
    return oldValue;
  }
}