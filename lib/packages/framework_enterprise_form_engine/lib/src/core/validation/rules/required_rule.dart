import '../../form_field.dart';
import '../../validation_result.dart';
import '../rule_type.dart';
import '../validation_rule_base.dart';

class RequiredRule extends ValidationRuleBase {
  @override
  RuleFieldType get type => RuleFieldType.required;

  RequiredRule(Map<String, dynamic>? config) : super(config: config);

  @override
  ValidationResult validate(FormFieldModel field, dynamic value) {
    final isEmpty =
        value == null ||
            (value is String && value.trim().isEmpty) ||
            (value is List && value.isEmpty);

    return isEmpty
        ? ValidationResult( message: config?['message'] ?? "${field.label} is required", isValid: false)
        : ValidationResult.valid();
  }
}
