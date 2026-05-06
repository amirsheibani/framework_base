import '../form_field/form_field_model.dart';
import 'validation_registry.dart';

class ValidationEngine {
  static List<String> validateField(FormFieldModel field, dynamic value) {
    final rules = field.validator;
    if (rules == null || rules.isEmpty) return [];

    final errors = <String>[];

    for (final ruleConfig in rules) {
      final rule = ValidationRegistry.create(ruleConfig.type, ruleConfig.config);
      final result = rule.validate(field, value);

      if (!result.isValid) {
        errors.add(result.message ?? "Invalid value");
      }
    }

    return errors;
  }
}
