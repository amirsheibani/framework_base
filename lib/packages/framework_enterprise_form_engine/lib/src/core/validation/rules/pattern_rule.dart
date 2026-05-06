

import 'package:collection/collection.dart';

import '../../form_field/form_field_model.dart';
import '../../validation_result.dart';
import '../rule_type.dart';
import '../validation_rule_base.dart';

class PatternRule extends ValidationRuleBase {
  @override
  RuleFieldType get type => RuleFieldType.pattern;

  PatternRule(Map<String, dynamic>? config) : super(config: config);

  @override
  ValidationResult validate(FormFieldModel field, dynamic value) {
    if (value == null) return ValidationResult.valid();
    if (value is! String) return ValidationResult.valid();

    final pattern = config?[RuleFieldType.pattern.toString()];
    if (pattern == null) return ValidationResult.valid();

    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      final message = field.validator?.firstWhereOrNull((item) => item.type == RuleFieldType.pattern)?.message;

      return ValidationResult(
          message: message ?? "${field.id} format is invalid", isValid: false);
    }

    return ValidationResult.valid();
  }
}
