

import 'package:collection/collection.dart';

import '../../form_field/form_field_model.dart';
import '../../validation_result.dart';
import '../rule_type.dart';
import '../validation_rule_base.dart';

class MinValueRule extends ValidationRuleBase {
  @override
  RuleFieldType get type => RuleFieldType.minValue;

  MinValueRule(Map<String, dynamic>? config) : super(config: config);

  @override
  ValidationResult validate(FormFieldModel field, dynamic value) {
    if (value == null || value is! num) return ValidationResult.valid();

    final min = config?[RuleFieldType.minValue.toString()] ?? 0;


    if (value < min) {
      final message = field.validator?.firstWhereOrNull((item) => item.type == RuleFieldType.minValue)?.message;
      return ValidationResult(
          message: message ?? "${field.id} must be >= $min",isValid: false);
    }

    return ValidationResult.valid();
  }
}
