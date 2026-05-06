

import 'package:collection/collection.dart';

import '../../form_field/form_field_model.dart';
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
      final message = field.validator?.firstWhereOrNull((item) => item.type == RuleFieldType.email)?.message;
      return ValidationResult(
          message: message ?? "${field.id} is not a valid email", isValid: false);
    }

    return ValidationResult.valid();
  }
}
