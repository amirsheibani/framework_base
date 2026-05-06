import 'package:collection/collection.dart';

import '../../form_field/form_field_model.dart';
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

    final result = fn(value, field);

    if (result) {
      return ValidationResult.valid();
    } else {
      final message = field.validator?.firstWhereOrNull((item) => item.type == RuleFieldType.custom)?.message;
      return ValidationResult(message: message ?? "${field.fieldType} is invalid", isValid: false);
    }
  }
}
