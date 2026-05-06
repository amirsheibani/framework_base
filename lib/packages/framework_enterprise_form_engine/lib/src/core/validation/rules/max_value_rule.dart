
import 'package:collection/collection.dart';

import '../../form_field/form_field_model.dart';
import '../../validation_result.dart';
import '../rule_type.dart';
import '../validation_rule_base.dart';

class MaxValueRule extends ValidationRuleBase {
  @override
  RuleFieldType get type => RuleFieldType.maxValue;

  MaxValueRule(Map<String, dynamic>? config) : super(config: config);

  @override
  ValidationResult validate(FormFieldModel field, dynamic value) {
    if (value == null || value is! num) return ValidationResult.valid();

    final max = config?[RuleFieldType.maxValue.toString()] ?? 9999999;

    if (value > max) {
      final message = field.validator?.firstWhereOrNull((item) => item.type == RuleFieldType.maxValue)?.message;
      return ValidationResult(
          message: message ??  "${field.id} must be <= $max", isValid: false);
    }

    return ValidationResult.valid();
  }
}
