import '../../form_field.dart';
import '../../validation_result.dart';
import '../rule_type.dart';
import '../validation_rule_base.dart';

class MinLengthRule extends ValidationRuleBase {
  @override
  RuleFieldType get type => RuleFieldType.minLength;

  MinLengthRule(Map<String, dynamic>? config) : super(config: config);

  @override
  ValidationResult validate(FormFieldModel field, dynamic value) {
    if (value == null) return ValidationResult.valid();

    final min = config?[RuleFieldType.minLength.toString()] ?? 0;

    if (value is String && value.length < min) {
      return ValidationResult(
          message: "${field.label} must be at least $min characters", isValid: false);
    }

    return ValidationResult.valid();
  }
}
