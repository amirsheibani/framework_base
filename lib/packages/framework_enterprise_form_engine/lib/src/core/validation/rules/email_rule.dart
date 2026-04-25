

import '../../form_field.dart';
import '../../validation_result.dart';
import '../rule_type.dart';
import '../validation_rule_base.dart';

class EmailRule extends ValidationRuleBase {
  @override
  RuleFieldType get type => RuleFieldType.email;

  EmailRule(Map<String, dynamic>? config) : super(config: config);

  @override
  ValidationResult validate(FormFieldModel field, dynamic value) {
    if (value == null || value is! String) return ValidationResult.valid();

    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

    if (!regex.hasMatch(value)) {
      return ValidationResult(
          message: config?['message'] ?? "${field.label} is not a valid email", isValid: false);
    }

    return ValidationResult.valid();
  }
}
