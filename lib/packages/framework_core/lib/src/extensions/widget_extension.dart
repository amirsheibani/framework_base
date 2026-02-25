import 'package:flutter/cupertino.dart';

extension OnInt on int {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}