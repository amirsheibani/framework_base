import 'condition.dart';
import 'field_type.dart';
import 'validation/rule_type.dart';

class ValidationRuleBaseConfig {
  final RuleFieldType type;
  final Map<String, dynamic>? config;

  ValidationRuleBaseConfig({
    required this.type,
    this.config,
  });

  factory ValidationRuleBaseConfig.fromJson(Map<String, dynamic> json) {
    return ValidationRuleBaseConfig(
      type: RuleFieldType.values
          .firstWhere((e) => e.toString() == 'RuleFieldType.' + json['type']),
      config: json['config'],
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'config': config,
  };
}

class FormFieldModel {
  final String name;
  final String? label;
  final String? placeholder;
  final FieldType type;
  final dynamic defaultValue;
  final List<dynamic>? options;
  final List<ValidationRuleBaseConfig>? validationRules;
  final List<FieldCondition>? visibleWhen;
  final List<FieldCondition>? enabledWhen;
  final List<FieldCondition>? requiredWhen;

  FormFieldModel({
    required this.name,
    this.label,
    this.placeholder,
    required this.type,
    this.defaultValue,
    this.validationRules,
    this.visibleWhen,
    this.enabledWhen,
    this.requiredWhen,
    this.options,
  });

  factory FormFieldModel.fromJson(Map<String, dynamic> json) {
    return FormFieldModel(
      name: json['name'],
      label: json['label'],
      placeholder: json['placeholder'],
      type: FieldType.values
          .firstWhere((e) => e.toString() == 'FieldType.' + json['type']),
      defaultValue: json['defaultValue'],

      // FIXED: جلوگیری از کرش در صورت نبودن options
      options: (json['options'] is List)
          ? List<dynamic>.from(json['options'])
          : null,

      validationRules: (json['validationRules'] as List?)
          ?.map((r) => ValidationRuleBaseConfig.fromJson(r))
          .toList(),

      visibleWhen: json['visibleWhen'] != null
          ? (json['visibleWhen'] as List)
          .map((e) => FieldCondition.fromJson(e))
          .toList()
          : null,

      enabledWhen: json['enabledWhen'] != null
          ? (json['enabledWhen'] as List)
          .map((e) => FieldCondition.fromJson(e))
          .toList()
          : null,

      requiredWhen: json['requiredWhen'] != null
          ? (json['requiredWhen'] as List)
          .map((e) => FieldCondition.fromJson(e))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'label': label,
    'placeholder': placeholder,
    'type': type.toString().replaceFirst('FieldType.', ''),
    'defaultValue': defaultValue,
    'options': options,
    'validationRules': validationRules?.map((e) => e.toJson()).toList(),
    'visibleWhen': visibleWhen?.map((e) => e.toJson()).toList(),
    'enabledWhen': enabledWhen?.map((e) => e.toJson()).toList(),
    'requiredWhen': requiredWhen?.map((e) => e.toJson()).toList(),
  };
}
