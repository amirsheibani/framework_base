import 'package:framework_base/packages/framework_enterprise_form_engine/lib/src/core/validation/rule_type.dart';

import 'validation_rule_base.dart';

typedef RuleBuilder = ValidationRuleBase Function(Map<String, dynamic>? config);

class ValidationRegistry {
  static final Map<RuleFieldType, RuleBuilder> _builders = {};

  static void register(RuleFieldType type, RuleBuilder builder) {
    _builders[type] = builder;
  }

  static ValidationRuleBase create(RuleFieldType type, Map<String, dynamic>? config) {
    final builder = _builders[type];
    if (builder == null) {
      throw Exception("Validation rule '$type' is not registered in ValidationRegistry.");
    }
    return builder(config);
  }
}
