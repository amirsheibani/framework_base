

import 'package:collection/collection.dart';

import '../../form_field/form_field_model.dart';
import '../../validation_result.dart';
import '../rule_type.dart';
import '../validation_rule_base.dart';

class MaxLengthRule extends ValidationRuleBase {
  @override
  RuleFieldType get type => RuleFieldType.maxLength;

  MaxLengthRule(Map<String, dynamic>? config) : super(config: config);

  @override
  ValidationResult validate(FormFieldModel field, dynamic value) {
    if (value == null) return ValidationResult.valid();

    final max = config?[RuleFieldType.maxLength.toString()] ?? 99999;


    if (value is String && value.length > max) {
      final message = field.validator?.firstWhereOrNull((item) => item.type == RuleFieldType.maxLength)?.message;
      return ValidationResult(
          message: message ?? "${field.id} must be at most $max characters", isValid: false);
    }

    return ValidationResult.valid();
  }
}
