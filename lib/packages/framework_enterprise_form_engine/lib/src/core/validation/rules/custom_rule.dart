import '../../form_field.dart';
import '../../validation_result.dart';
import '../rule_type.dart';
import '../validation_rule_base.dart';

typedef CustomValidator = bool Function(dynamic value, FormFieldModel field);

class CustomRule extends ValidationRuleBase {
  @override
  RuleFieldType get type => RuleFieldType.custom;

  CustomRule(Map<String, dynamic>? config) : super(config: config);

  @override
  ValidationResult validate(FormFieldModel field, dynamic value) {
    final fn = config?['validator'];
    if (fn is! CustomValidator) {
      return ValidationResult.valid();
    }

    final ok = fn(value, field);

    return ok ? ValidationResult.valid() : ValidationResult(message: config?['message'] ?? "${field.label} is invalid", isValid: false);
  }
}
