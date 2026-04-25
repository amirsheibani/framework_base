enum ConditionOperator {
  equals,
  notEquals,
  greaterThan,
  lessThan,
  contains,
  inList
}

class FieldCondition {
  final String field;
  final ConditionOperator operator;
  final dynamic value;

  FieldCondition({
    required this.field,
    required this.operator,
    required this.value,
  });

  factory FieldCondition.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return FieldCondition(
        field: '',
        operator: ConditionOperator.equals,
        value: null,
      );
    }

    return FieldCondition(
      field: json['field'],
      operator: ConditionOperator.values.firstWhere(
            (op) => op.toString() == 'ConditionOperator.${json['operator']}',
        orElse: () => ConditionOperator.equals,
      ),
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() => {
    'field': field,
    'operator': operator.toString().split('.').last,
    'value': value,
  };
}
