import 'package:flutter/material.dart';
import 'package:framework_base/framework_base.dart';

import 'form_handler.dart';

class FormLayout extends FormWidget with FormHandler{
  double? height;
  double? width;
  String? decoration;
  FormWidget? child;


  FormLayout({this.height, this.width, this.decoration, this.child,});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['height'] = height;
    map['width'] = width;
    if (decoration != null) {
      map['decoration'] = decoration.toString();
    }
    if (child != null) {
      map['child'] = child!.toJson();
    }
    return map;
  }

  @override
  FormWidget fromJson(Map<String, dynamic> json) {

    child = createChild(json);
    return FormLayout(
      height: json['height'] as double?,
      width: json['width'] as double?,
      decoration: json['decoration'] as String?,
      child: child,
    );
  }

  @override
  Widget toWidget() {
    return decoration == null
        ? SizedBox(width: width ?? double.maxFinite, height: height ?? double.maxFinite, child: child?.toWidget() ?? const SizedBox(),)
        : Container(width: width ?? double.maxFinite, height: height ?? double.maxFinite, decoration: decoration.toDecoration, child: child?.toWidget() ?? const SizedBox(),);
  }
}
extension _OnDecoration on String?{
  BoxDecoration? get toDecoration{
    if(this == null){
      return null;
    }else{
      return BoxDecoration();
    }
  }
}