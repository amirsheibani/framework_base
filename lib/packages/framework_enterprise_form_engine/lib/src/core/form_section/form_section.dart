import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:framework_base/framework_base.dart';
import 'package:framework_base/packages/framework_enterprise_form_engine/lib/src/core/form_section/padding/padding_horizontal.dart';
import 'package:framework_base/packages/framework_enterprise_form_engine/lib/src/core/form_section/padding/padding_vertical.dart';

import '../field_type.dart';
import '../form_field/form_field_model.dart';
import 'decoration/decoration.dart';
import 'margin/margin.dart';
import 'margin/margin_all.dart';
import 'margin/margin_horizontal.dart';
import 'margin/margin_only.dart';
import 'margin/margin_vertical.dart';
import 'padding/padding.dart';
import 'padding/padding_all.dart';
import 'padding/padding_only.dart';
import 'section_type.dart';

class FormSectionModel {
  final String id;
  final String title;
  final TextStyleEnum? titleStyle;
  final String? titleColor;
  final FormSectionDecoration? decoration;
  final FormSectionPadding? padding;
  final FormSectionMargin? margin;
  final SectionType? type;
  final FormFieldModel? field;
  final FormSectionModel? child;
  final List<FormSectionModel>? children;
  final double? height;
  final double? width;
  final MainAxisAlignment? mainAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final bool scroll;
  final int? flex;
  final FlexFit? fit;
  final bool? visible;
  final bool? enabled;
  final List<ExpressionModel>? expressions;
  final String? visibilityExpression;

  FormSectionModel({
    required this.id,
    this.title = '',
    this.field,
    this.child,
    this.children,
    required this.type,
    this.titleStyle,
    this.titleColor,
    this.decoration,
    this.height,
    this.width,
    this.mainAxisAlignment,
    this.mainAxisSize,
    this.scroll = false,
    this.flex,
    this.fit,
    this.visible = true,
    this.enabled = true,
    this.padding,
    this.margin,
    this.expressions,
    this.visibilityExpression,
  });

  factory FormSectionModel.fromJson(Map<String, dynamic> json) {
    FormFieldModel? field;
    if (json['field'] != null) {
      field = _parseField(Map<String, dynamic>.from(json['field'] as Map));
    } else if (_jsonLooksLikeInlineField(json)) {
      field = _parseField(Map<String, dynamic>.from(json));
    }

    var sectionType =
        SectionType.values.firstWhereOrNull((item) => item.name == json['type']);

    if (field != null) {
      if (json['field'] != null) {
        sectionType ??= SectionType.field;
      } else {
        sectionType = SectionType.field;
      }
    }

    return FormSectionModel(
      id: json['id'],
      title: json['title'] as String? ?? '',
      titleStyle: json['titleStyle'] != null ? TextStyleEnum.values.firstWhereOrNull((e) => e.name == json['titleStyle']) : null,
      titleColor: json['titleColor'] as String?,
      type: sectionType,
      height: json['height'] != null ? json['height'] as double : null,
      width: json['width'] != null ? json['width'] as double : null,
      mainAxisAlignment: json['mainAxisAlignment'] != null
          ? MainAxisAlignment.values.firstWhereOrNull((item) => item.name == json['mainAxisAlignment'])
          : null,
      mainAxisSize: json['mainAxisSize'] != null
          ? MainAxisSize.values.firstWhereOrNull((item) => item.name == json['mainAxisSize'])
          : null,
      scroll: json['scroll'] as bool? ?? false,
      flex: json['flex'] as int?,
      fit: json['fit'] != null
          ? FlexFit.values.firstWhereOrNull((item) => item.name == json['fit'])
          : null,
      decoration: json['decoration'] != null ? FormSectionDecoration.fromJson(json['decoration']) : null,

        expressions: json['expressions'] != null ?(json['expressions'] as List).map((item) => ExpressionModel.fromJson(item)).toList() : null,
      visibilityExpression: json['visibilityExpression'] as String?,
      field: field,
      children: json['children'] != null
          ? (json['children'] as List)
              .map((item) => FormSectionModel.fromJson(item))
              .toList()
          : null,
      child: json['child'] != null
          ? FormSectionModel.fromJson(json['child'])
          : null,

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

      margin: () {
        if (json['margin_all'] != null) {
          return FormSectionMarginAll(value: json['margin_all']);
        } else if (json['margin_horizontal'] != null) {
          return FormSectionMarginHorizontal(value: json['margin_horizontal']);
        } else if (json['margin_vertical'] != null) {
          return FormSectionMarginVertical(value: json['margin_vertical']);
        } else if (json['margin_only'] != null) {
          return FormSectionMarginOnly.fromJson(json['margin_only']);
        } else {
          return null;
        }
      }(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {'id': id};
    if (title.isNotEmpty) {
      map['title'] = title;
    }
    if (titleStyle != null) {
      map['titleStyle'] = titleStyle!.name;
    }
    if (titleColor != null) {
      map['titleColor'] = titleColor;
    }
    if (type != null) {
      map['type'] = type!.name;
    }
    if (height != null) {
      map['height'] = height;
    }
    if (width != null) {
      map['width'] = width;
    }
    if (mainAxisAlignment != null) {
      map['mainAxisAlignment'] = mainAxisAlignment!.name;
    }
    if (mainAxisSize != null) {
      map['mainAxisSize'] = mainAxisSize!.name;
    }
    if (scroll) {
      map['scroll'] = true;
    }
    if (flex != null) {
      map['flex'] = flex;
    }
    if (fit != null) {
      map['fit'] = fit!.name;
    }
    if (decoration != null) {
      map['decoration'] = decoration!.toJson();
    }
    if (field != null) {
      map['field'] = field!.toJson();
    }
    if (child != null) {
      map['child'] = child!.toJson();
    }
    if (children != null) {
      map['children'] = children!.map((item) => item.toJson()).toList();
    }
    if (padding != null) {
      if (padding is FormSectionPaddingVertical) {
        map['padding_vertical'] = (padding as FormSectionPaddingVertical).value;
      } else if (padding is FormSectionPaddingHorizontal) {
        map['padding_horizontal'] = (padding as FormSectionPaddingHorizontal).value;
      } else if (padding is FormSectionPaddingAll) {
        map['padding_all'] = (padding as FormSectionPaddingAll).value;
      } else if (padding is FormSectionPaddingOnly) {
        map['padding_only'] = (padding as FormSectionPaddingOnly).toJson();
      }
    }
    if (margin != null) {
      if (margin is FormSectionMarginVertical) {
        map['margin_vertical'] = (margin as FormSectionMarginVertical).value;
      } else if (margin is FormSectionMarginHorizontal) {
        map['margin_horizontal'] = (margin as FormSectionMarginHorizontal).value;
      } else if (margin is FormSectionMarginAll) {
        map['margin_all'] = (margin as FormSectionMarginAll).value;
      } else if (margin is FormSectionMarginOnly) {
        map['margin_only'] = (margin as FormSectionMarginOnly).toJson();
      }
    }
    return map;
  }

  /// JSON where field props live at the section root (`fieldType`, etc.) instead of under `"field"`.
  static bool _jsonLooksLikeInlineField(Map<String, dynamic> json) {
    final ft = json['fieldType'];
    if (ft is! String) return false;
    return FieldType.values.any((e) => e.name == ft);
  }

  static FormFieldModel _parseField(Map<String, dynamic> item) {
    if (item['fieldType'] == 'appTextFormField') {
      return AppTextFieldModel.fromJson(item);
    }
    if (item['fieldType'] == 'appText') {
      return AppTextModel.fromJson(item);
    }
    throw UnsupportedError("Unsupported fieldType '${item['fieldType']}'");
  }
}


class ExpressionModel{

  final String expression;
  final String? resultFieldId;

  ExpressionModel({required this.expression, this.resultFieldId});

  factory ExpressionModel.fromJson(Map<String, dynamic> json) {
    return ExpressionModel(expression: json['exp'],resultFieldId:json['resultFieldId']);
  }
  Map<String, dynamic> toJson() {
    return {'exp': expression, 'resultFieldId': resultFieldId};
  }
}
