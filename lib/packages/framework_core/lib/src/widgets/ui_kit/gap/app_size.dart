import 'package:flutter/widgets.dart';

class AppSize {
  const AppSize._();
  static const double nano = 2.0;
  static const double xxsmall = 4.0;
  static const double xsmall = 8.0;
  static const double small = 12.0;
  static const double base = 16.0;
  static const double medium = 24.0;
  static const double large = 32.0;
  static const double xlarge = 40.0;
  static const double xxlarge = 48.0;
  static const double xxxlarge = 64.0;
  static const double huge = 80.0;
  static const double gigantic = 96.0;
}

extension AppGapExtension on num {
  SizedBox get gapHeight => SizedBox(height: toDouble());
  SizedBox get gapWidth => SizedBox(width: toDouble());
}



