extension OnformatIBAN on String{
  String get formatIBAN {
    String clean = replaceAll(" ", "").toUpperCase();

    clean = clean.replaceAll("IR", "");
    clean = clean.replaceAll(RegExp(r'[^0-9]'), '');

    if (clean.length > 24) {
      clean = clean.substring(0, 24);
    }

    final b = StringBuffer();

    for (int i = 0; i < clean.length; i++) {
      b.write(clean[i]);

      if ((i + 1) % 4 == 0 && i + 1 != clean.length) {
        b.write(" ");
      }
    }

    return b.toString();
  }
}