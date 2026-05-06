extension OnformatDate on String{
  String get formatDate {
    String digits = replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.length > 8) {
      digits = digits.substring(0, 8);
    }

    if (digits.length <= 4) {
      return digits;
    } else if (digits.length <= 6) {
      return '${digits.substring(0, 4)}/${digits.substring(4)}';
    } else {
      return '${digits.substring(0, 4)}/${digits.substring(4, 6)}/${digits.substring(6)}';
    }
  }
}