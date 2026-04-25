import 'package:collection/collection.dart';
import 'package:framework_base/packages/framework_enterprise_form_engine/lib/src/core/form_section/padding/padding_horizontal.dart';
import 'package:framework_base/packages/framework_enterprise_form_engine/lib/src/core/form_section/padding/padding_vertical.dart';

import '../form_field.dart';
import 'decoration/decoration.dart';
import 'padding/padding.dart';
import 'padding/padding_all.dart';
import 'padding/padding_only.dart';
import 'section_type.dart';

class FormSectionModel {
  final String id;
  final String title;
  final FormSectionDecoration? decoration;
  final FormSectionPadding? padding;
  final SectionType? type;
  final List<FormFieldModel>? fields;
  final double? height;
  final double? width;
  final bool? visible;
  final bool? enabled;

  FormSectionModel({required this.id, required this.title, required this.fields, required this.type, this.decoration, this.height, this.width, this.visible = true, this.enabled = true, this.padding});

  factory FormSectionModel.fromJson(Map<String, dynamic> json) {
    return FormSectionModel(
      id: json['id'],
      title: json['title'],
      type: SectionType.values.firstWhereOrNull((item) => item.name == json['type']),
      height: json['height'] != null ?  json['height'] as double : null,
      width: json['width'] != null ? json['width'] as double : null,
      decoration: json['decoration'] != null ? FormSectionDecoration.fromJson(json['decoration']) : null,
      fields: json['fields'] != null ? (json['fields'] as List).map((f) => FormFieldModel.fromJson(f)).toList():null,
      padding: () {
        if (json['padding_all'] != null) {
          return FormSectionPaddingAll(value: json['padding_all']);
        } else if (json['padding_horizontal'] != null) {
          return FormSectionPaddingHorizontal(value: json['padding_horizontal']);
        } else if (json['padding_vertical'] != null) {
          return FormSectionPaddingVertical(value: json['padding_vertical']);
        } else if (json['padding_only'] != null) {
          return FormSectionPaddingOnly.fromJson(json['padding_only']);
        } else {
          return null;
        }
      }(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {'id': id, 'title': title};
    if (type != null) {
      map['type'] = type!.name;
    }
    if (height != null) {
      map['height'] = height;
    }
    if (width != null) {
      map['width'] = width;
    }
    if (decoration != null) {
      map['decoration'] = decoration!.toJson();
    }
    if (fields != null) {
      map['fields'] = fields!.map((item) => item.toJson()).toList();
    }
    if(padding != null){
      if(padding is FormSectionPaddingVertical) {
        map['padding_vertical'] = (padding as FormSectionPaddingVertical).value;
      }
      else if(padding is FormSectionPaddingHorizontal){
        map['padding_horizontal'] = (padding as FormSectionPaddingHorizontal).value;
      }
      else if(padding is FormSectionPaddingAll){
        map['padding_all'] = (padding as FormSectionPaddingAll).value;
      }else if(padding is FormSectionPaddingOnly){
        map['padding_only'] = (padding as FormSectionPaddingOnly).toJson();
      }
    }
    return map;
  }
}
