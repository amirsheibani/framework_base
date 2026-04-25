
import '../../form_field.dart';
import '../../validation_result.dart';
import '../rule_type.dart';
import '../validation_rule_base.dart';

class PhoneRule extends ValidationRuleBase {
  @override
  RuleFieldType get type => RuleFieldType.phone;

  PhoneRule(Map<String, dynamic>? config) : super(config: config);

  @override
  ValidationResult validate(FormFieldModel field, dynamic value) {
    if (value == null || value is! String) return ValidationResult.valid();

    final regex = RegExp(r'^[0-9]{10,15}$');

    if (!regex.hasMatch(value)) {
      return ValidationResult(
          message: config?['message'] ?? "${field.label} is not a valid phone",isValid: false);
    }

    return ValidationResult.valid();
  }
}
