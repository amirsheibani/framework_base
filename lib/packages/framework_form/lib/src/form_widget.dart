import 'package:flutter/cupertino.dart';


abstract class FormWidget {
  FormWidget fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();

  Widget? toWidget();
}



