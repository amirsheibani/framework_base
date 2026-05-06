import '../form_field/form_field_model.dart';
import '../validation_result.dart';
import 'rule_type.dart';

abstract class ValidationRuleBase {
  RuleFieldType get type;

  /// config شامل مقادیر rule مثل:
  /// { "min": 3 }, { "pattern": "^[0-9]+\$" }
  final Map<String, dynamic>? config;

  ValidationRuleBase({this.config});

  /// هر rule باید خودش را validate کند
  ValidationResult validate(FormFieldModel field, dynamic value);
}
