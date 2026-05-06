import 'dart:ui';

import '../../../../../../../framework_base.dart';
import '../border_radius/border_radius.dart';
import '../border_radius/border_radius_all.dart';
import '../border_radius/border_radius_crcular.dart';
import '../border_radius/border_radius_only.dart';

class FormSectionDecoration {
  final Color? color;
  final FormDecorationBorderRadius? formDecorationBorderRadius;

  FormSectionDecoration({this.color, this.formDecorationBorderRadius});

  factory FormSectionDecoration.fromJson(Map<String, dynamic> json) {
    return FormSectionDecoration(
      color: json['color'] != null ? (json['color'] as String).hexToColor : null,

      formDecorationBorderRadius: () {
        // Supports multiple JSON shapes:
        // - form_schema.json style: borderRadiusAll / borderRadiusCircular / borderRadiusOnly
        // - data.json convenience: borderRadius (alias for borderRadiusAll)
        if (json['borderRadiusAll'] != null || json['borderRadius'] != null) {
          return FormDecorationBorderRadiusAll(borderRadius: json['borderRadiusAll'] ?? json['borderRadius']);
        } else if (json['borderRadiusCircular'] != null) {
          return FormDecorationBorderRadiusCircular(borderRadius: json['borderRadiusCircular']);
        } else if (json['borderRadiusOnly'] != null) {
          return FormDecorationBorderRadiusOnly.fromJson(json['borderRadiusOnly']);
        } else {
          return null;
        }
      }(),
    );
  }

  Map<String, dynamic> toJson(){
    final map = <String, dynamic>{};
    if(color != null){
      map['color'] = color.toString();
    }
    if(formDecorationBorderRadius is FormDecorationBorderRadiusAll){
      map['borderRadiusAll'] = (formDecorationBorderRadius as FormDecorationBorderRadiusAll).borderRadius;
    }
    if(formDecorationBorderRadius is FormDecorationBorderRadiusCircular){
      map['borderRadiusCircular'] = (formDecorationBorderRadius as FormDecorationBorderRadiusCircular).borderRadius;
    }
    if(formDecorationBorderRadius is FormDecorationBorderRadiusOnly){
      map['borderRadiusOnly'] = (formDecorationBorderRadius as FormDecorationBorderRadiusOnly).toJson();
    }
    return map;
  }
}