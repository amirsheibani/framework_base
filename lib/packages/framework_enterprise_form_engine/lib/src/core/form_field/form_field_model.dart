import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/painting.dart';
import 'package:framework_base/packages/framework_enterprise_form_engine/lib/src/core/form_section/form_section.dart';

import '../../../../../../framework_base.dart';
import '../condition.dart';
import '../field_type.dart';
import '../validation/rule_type.dart';

class ValidationRuleBaseConfig {
  final RuleFieldType type;
  final Map<String, dynamic>? config;
  final String? message;

  ValidationRuleBaseConfig({required this.type, this.config, this.message});

  factory ValidationRuleBaseConfig.fromJson(Map<String, dynamic> json) {
    return ValidationRuleBaseConfig(type: RuleFieldType.values.firstWhere((e) => e.name == json['type']), config: json['config'], message: json['message']);
  }

  Map<String, dynamic> toJson() => {'type': type, 'config': config, 'message': message};
}

class FormFieldModel {
  List<ValidationRuleBaseConfig>? validator;
  final String id;
  final FieldType fieldType;
  final dynamic value;
  final ExpressionModel? expression;
  final String? visibilityExpression;

  final List<FieldCondition>? visibleWhen;
  final List<FieldCondition>? enabledWhen;
  final List<FieldCondition>? requiredWhen;

  FormFieldModel({this.validator, required this.id, required this.fieldType, this.value, this.expression, this.visibleWhen, this.enabledWhen, this.requiredWhen, this.visibilityExpression});

  Map<String, dynamic> toJson() => {
        'id': id,
        'fieldType': fieldType.name,
        'value': value,
        'expression': expression?.toJson(),
        'visibilityExpression': visibilityExpression,
        'validationRules': validator?.map((e) => e.toJson()).toList(),
        'visibleWhen': visibleWhen?.map((e) => e.toJson()).toList(),
        'enabledWhen': enabledWhen?.map((e) => e.toJson()).toList(),
        'requiredWhen': requiredWhen?.map((e) => e.toJson()).toList(),
      };
}

class AppTextFieldModel extends FormFieldModel {
  final AppTextFormFieldType type;
  final AppTextFormFieldSize size;
  final AppTextFormFieldCurrency? currency;
  final String? label;
  final String? hint;
  final String? helperText;
  final bool? isRequired;
  final bool? enabled;
  final bool? readOnly;

  // final VoidCallback? labelTap;
  // final VoidCallback? onTap;
  // final ValueChanged<String?>? onSaved;
  // final VoidCallback? onEditingComplete;
  // final ValueChanged<String?>? onFieldSubmitted;
  // final ValueChanged<String?>? onChanged;
  final bool? enableSuggestions;
  final bool? autocorrect;

  // final Widget? suffixWidget;
  // final VoidCallback? onTapSuffix;
  // final Widget? prefixWidget;
  // final VoidCallback? onTapPrefix;
  // final VoidCallback? onTapSuffixCurrency;
  // final VoidCallback? onTapSuffixIban;
  final bool? autoFontResize;
  final int? maxLength;
  final bool? showCharacterCount;

  AppTextFieldModel({
    required super.id,
    required super.fieldType,
    required this.type,
    required this.size,
    this.currency,
    this.label,
    String? super.value,
    this.hint,
    this.helperText,
    this.isRequired,
    this.enabled,
    this.readOnly,
    this.enableSuggestions,
    this.autocorrect,
    this.autoFontResize,
    this.maxLength,
    this.showCharacterCount,
    super.expression,
    super.visibilityExpression,
    super.validator,
    super.visibleWhen,
    super.enabledWhen,
    super.requiredWhen,
  });

  factory AppTextFieldModel.fromJson(Map<String, dynamic> json) {
    final model  = AppTextFieldModel(
      id: json['id'],
      fieldType: FieldType.values.firstWhere((e)=> e.name == json['fieldType']),
      type: AppTextFormFieldType.values.firstWhereOrNull((e) => e.name == json['type']) ?? AppTextFormFieldType.text,
      size: AppTextFormFieldSize.values.firstWhereOrNull((e) => e.name == json['size']) ?? AppTextFormFieldSize.large,
      currency: AppTextFormFieldCurrency.values.firstWhereOrNull((e) => e.name == json['currency']),
      label: json['label'],
      value: json['value'],
      hint: json['hint'],
      helperText: json['helperText'],
      isRequired: json['isRequired'],
      enabled: json['enabled'],
      readOnly: json['readOnly'],
      enableSuggestions: json['enableSuggestions'],
      autocorrect: json['autocorrect'],
      expression: json['expression'] != null ? ExpressionModel.fromJson(json['expression']) : null,
      visibilityExpression: json['visibilityExpression'] as String?,

      validator: (json['validationRules'] as List?)?.map((r) => ValidationRuleBaseConfig.fromJson(r)).toList(),

      visibleWhen: json['visibleWhen'] != null ? (json['visibleWhen'] as List).map((e) => FieldCondition.fromJson(e)).toList() : null,

      enabledWhen: json['enabledWhen'] != null ? (json['enabledWhen'] as List).map((e) => FieldCondition.fromJson(e)).toList() : null,

      requiredWhen: json['requiredWhen'] != null ? (json['requiredWhen'] as List).map((e) => FieldCondition.fromJson(e)).toList() : null,
    );
    return model;
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'fieldType': fieldType.name,
        'type': type.name,
        'size': size.name,
        'currency': currency?.name,
        'label': label,
        'value': value,
        'hint': hint,
        'helperText': helperText,
        'isRequired': isRequired,
        'enabled': enabled,
        'readOnly': readOnly,
        'enableSuggestions': enableSuggestions,
        'autocorrect': autocorrect,
        'expression': expression?.toJson(),
        'visibilityExpression': visibilityExpression,
        'validationRules': validator?.map((e) => e.toJson()).toList(),
        'visibleWhen': visibleWhen?.map((e) => e.toJson()).toList(),
        'enabledWhen': enabledWhen?.map((e) => e.toJson()).toList(),
        'requiredWhen': requiredWhen?.map((e) => e.toJson()).toList(),
      };
}

class AppTextModel extends FormFieldModel {
  final TextSelectedType? selectedType;
  final AppTextType? appTextType;
  final TextStyleEnum? style;
  final String? color;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final String? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? semanticsLabel;
  final String? semanticsIdentifier;
  final TextWidthBasis? textWidthBasis;

  AppTextModel({
    required super.id,
    required super.fieldType,
    required super.value,
    this.selectedType,
    this.appTextType,
    this.style,
    this.color,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.semanticsIdentifier,
    this.textWidthBasis,
    super.expression,
    super.visibilityExpression,
    super.validator,
    super.visibleWhen,
    super.enabledWhen,
    super.requiredWhen,
  });

  factory AppTextModel.fromJson(Map<String, dynamic> json) {
    return AppTextModel(
      id: json['id'],
      fieldType: FieldType.values.firstWhere((e) => e.name == (json['fieldType'])),
      value: json['value'],
      selectedType: TextSelectedType.values.firstWhereOrNull((e) => e.name == json['selectedType']) ?? TextSelectedType.nonSelectable,
      appTextType: AppTextType.values.firstWhereOrNull((e) => e.name == json['appTextType']) ?? AppTextType.text,
      style: TextStyleEnum.values.firstWhereOrNull((e) => e.name == json['style']),
      color: json['color'],
      textAlign: TextAlign.values.firstWhereOrNull((e) => e.name == json['textAlign']),
      textDirection: TextDirection.values.firstWhereOrNull((e) => e.name == json['textDirection']),
      locale: json['locale'],
      softWrap: json['softWrap'],
      overflow: TextOverflow.values.firstWhereOrNull((e) => e.name == json['overflow']),
      maxLines: json['maxLines'],
      semanticsLabel: json['semanticsLabel'],
      semanticsIdentifier: json['semanticsIdentifier'],
      textWidthBasis: TextWidthBasis.values.firstWhereOrNull((e) => e.name == json['textWidthBasis']),
      expression:  json['expression'] != null ? ExpressionModel.fromJson(json['expression']) : null,
        visibilityExpression : json['visibilityExpression'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'fieldType': fieldType.name,
        'value': value,
        'selectedType': selectedType?.name,
        'appTextType': appTextType?.name,
        'style': style?.name,
        'color': color,
        'textAlign': textAlign?.name,
        'textDirection': textDirection?.name,
        'locale': locale,
        'softWrap': softWrap,
        'overflow': overflow?.name,
        'maxLines': maxLines,
        'semanticsLabel': semanticsLabel,
        'semanticsIdentifier': semanticsIdentifier,
        'textWidthBasis': textWidthBasis?.name,
        'expression': expression?.toJson(),
        'visibilityExpression': visibilityExpression,
        'validationRules': validator?.map((e) => e.toJson()).toList(),
        'visibleWhen': visibleWhen?.map((e) => e.toJson()).toList(),
        'enabledWhen': enabledWhen?.map((e) => e.toJson()).toList(),
        'requiredWhen': requiredWhen?.map((e) => e.toJson()).toList(),
      };
}
