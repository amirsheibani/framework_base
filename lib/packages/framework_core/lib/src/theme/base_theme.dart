import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ThemeType { light, dark, system }


class PalletColor extends MaterialColor {
  const PalletColor(super.primary, super.swatch);

  /// The lightest shade.
  Color get shade99 => this[99]!;

  /// The second lightest shade.
  Color get shade95 => this[95]!;

  /// The third lightest shade.
  Color get shade90 => this[90]!;

  /// The fourth lightest shade.
  Color get shade80 => this[80]!;

  /// The fifth lightest shade.
  Color get shade70 => this[70]!;

  /// The default shade.
  Color get shade60 => this[60]!;

  /// The fifth darkest shade.
  @override
  Color get shade50 => this[50]!;

  /// The fourth darkest shade.
  Color get shade40 => this[40]!;

  /// The third darkest shade.
  Color get shade30 => this[30]!;

  /// The second shade.
  Color get shade20 => this[20]!;

  /// The darkest shade.
  Color get shade10 => this[10]!;

  Color get shade0 => this[0]!;
}

