import 'package:collection/collection.dart';

import '../core/condition.dart';
import '../core/field_type.dart';
import '../core/form_schema.dart';
import '../core/form_field.dart';
import '../core/validation/validation_engine.dart';
import 'form_field_state.dart';
import 'form_section_state.dart';

typedef FormListener = void Function();

class FormStateController {
  final FormSchema schema;

  /// internal state storage
  final Map<String, FormFieldState> _fields = {};
  final Map<String, FormSectionState> _sections  = {};

  /// listeners for UI update (Flutter or any UI framework)
  final List<FormListener> _listeners = [];

  FormStateController(this.schema) {
    _initializeFields();
  }

  /// load default values & prepare field states
  void _initializeFields() {
    for (var section in schema.sections) {
      _sections[section.title]=FormSectionState(
      );
      for (var field in section.fields ?? []) {
        _fields[field.name] = FormFieldState(
          value: field.defaultValue,
          errors: [],
        );
      }
    }
  }

  /// listen for changes
  void addListener(FormListener listener) {
    _listeners.add(listener);
  }

  void removeListener(FormListener listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners() {
    for (var l in _listeners) {
      l();
    }
  }

  /// get field value
  dynamic getValue(String fieldName) {
    return _fields[fieldName]?.value;
  }

  /// get field value
  dynamic getAllValues() {
    return _fields.values;
  }

  bool evaluateCondition(FieldCondition cond) {
    final otherValue = getValue(cond.field);

    switch (cond.operator) {
      case ConditionOperator.equals:
        return otherValue == cond.value;
      case ConditionOperator.notEquals:
        return otherValue != cond.value;
      case ConditionOperator.greaterThan:
        return (otherValue is num && cond.value is num) &&
            otherValue > cond.value;
      case ConditionOperator.lessThan:
        return (otherValue is num && cond.value is num) &&
            otherValue < cond.value;
      case ConditionOperator.contains:
        return (otherValue is List) && otherValue.contains(cond.value);
      case ConditionOperator.inList:
        return (cond.value is List) && cond.value.contains(otherValue);
    }
  }

  bool isFieldVisible(String fieldName) {

    final field = schema.allFields.firstWhereOrNull((item) => item.name == fieldName);
    if (field?.visibleWhen == null) return true;
    return field!.visibleWhen!.every(evaluateCondition);
  }

  bool isFieldEnabled(String fieldName) {
    final field = schema.allFields.firstWhereOrNull((item) => item.name == fieldName);
    if (field?.enabledWhen == null) return true;
    return field!.enabledWhen!.every(evaluateCondition);
  }

  bool isFieldRequired(String fieldName) {
    final field = schema.allFields.firstWhereOrNull((item) => item.name == fieldName);
    if (field?.requiredWhen == null) return false;
    return field!.requiredWhen!.every(evaluateCondition);
  }

  void evaluateAllConditionalFields() {
    bool changed = false;

    for (final field in schema.allFields) {
      final name = field.name;
      final state = _fields[name];
      if (state == null) continue;

      final newVisible = isFieldVisible(name);
      final newEnabled = isFieldEnabled(name);

      if (state.visible != newVisible || state.enabled != newEnabled) {
        changed = true;
      }

      state.visible = newVisible;
      state.enabled = newEnabled;

      if (!newVisible) {
        state.value = null;
        state.errors = [];
      }
    }

    if (changed) {
      _notifyListeners();
    }
  }


  void setValue(String fieldName, dynamic value) {
    final state = _fields[fieldName];
    if (state == null) return;

    state.value = value;

    final field = schema.allFields.firstWhereOrNull((f) => f.name == fieldName);
    if (field != null) {
      validateField(field);
    }

    evaluateAllConditionalFields();

    _notifyListeners();
  }



  /// return final JSON data
  Map<String, dynamic> toJson() {
    return {
      for (var key in _fields.keys) key: _fields[key]!.value
    };
  }


  List<String> validateField(FormFieldModel field) {
    final value = getValue(field.name);

    final state = _fields[field.name];
    if (state == null) return [];

    // شرط requiredWhen
    if (isFieldRequired(field.name)) {
      if (value == null || value.toString().trim().isEmpty) {
        state.errors = ["این فیلد اجباری است"];
        return state.errors;
      }
    }

    // ruleهای ValidationEngine
    final errors = ValidationEngine.validateField(field, value);

    state.errors = errors;
    return errors;
  }

  Map<String, List<String>> validateAll() {
    final result = <String, List<String>>{};

    for (final field in schema.allFields) {
      final value = getValue(field.name);
      final errors = ValidationEngine.validateField(field, value);

      _fields[field.name]?.errors = errors;

      if (errors.isNotEmpty) {
        result[field.name] = errors;
      }
    }
    _notifyListeners();
    return result;
  }

  bool get isFormValid {
    for (final field in _fields.values) {
      if (field.errors.isNotEmpty) {
        return false;
      }
    }
    return true;
  }

  FormFieldState? getFieldState(String fieldName) {
    return _fields[fieldName];
  }

  FormSectionState? getSectionState(String sectionName) {
    return _sections[sectionName];
  }

  Map<String, FormFieldState> get allFieldStates => _fields;

}
