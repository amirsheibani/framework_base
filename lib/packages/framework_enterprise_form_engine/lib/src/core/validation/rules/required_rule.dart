import 'package:collection/collection.dart';

import '../../form_field/form_field_model.dart';
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

    if(isEmpty){
      final message = field.validator?.firstWhereOrNull((item) => item.type == RuleFieldType.required)?.message;
      return ValidationResult( message: message ?? "${field.id} is required", isValid: false);
    }else{
      return ValidationResult.valid();
    }
  }
}
