import 'package:collection/collection.dart';
import 'package:expressions/expressions.dart';
import '../core/condition.dart';
import '../core/form_field/form_field_model.dart';
import '../core/form_schema.dart';
import '../core/validation/validation_engine.dart';
import 'form_field_state.dart';
import 'form_section_state.dart';

typedef FormListener = void Function();

class FormStateController {
  final FormSchema schema;

  /// internal state storage
  final Map<String, FormFieldState> _fields = {};
  final Map<String, FormSectionState> _sections = {};

  /// listeners for UI update (Flutter or any UI framework)
  final List<FormListener> _listeners = [];

  FormStateController(this.schema) {
    _initializeFields();
    // ✅ بعد از initialize، expressions و visibility را محاسبه کن
    evaluateAllConditionalFields();
    _evaluateExpressions();
  }

  void dispose() {
    for (var field in _fields.values) {
      field.dispose();  // هر field state رو dispose کن
    }
    _listeners.clear();
  }

  /// load default values & prepare field states
  void _initializeFields() {
    for (var section in schema.allSections) {
      _sections[section.id] = FormSectionState();
      final field = section.field;
      if (field != null) {
        _fields[field.id] = FormFieldState(
          value: field.value,
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

  bool isFieldVisible(String id) {

    final field = schema.allFields.firstWhereOrNull((item) => item?.id == id);
    if (field?.visibleWhen == null) return true;
    return field!.visibleWhen!.every(evaluateCondition);
  }

  bool isFieldEnabled(String id) {
    final field = schema.allFields.firstWhereOrNull((item) => item?.id == id);
    if (field?.enabledWhen == null) return true;
    return field!.enabledWhen!.every(evaluateCondition);
  }

  bool isFieldRequired(String id) {
    final field = schema.allFields.firstWhereOrNull((item) => item?.id == id);
    if (field?.requiredWhen == null) return false;
    return field!.requiredWhen!.every(evaluateCondition);
  }

  void evaluateAllConditionalFields() {
    bool changed = false;

    // ✅ Sections رو evaluate کن
    for (final section in schema.allSections) {
      final sectionState = _sections[section.id];
      if (sectionState != null && section.visibilityExpression != null) {
        try {
          final exp = Expression.parse(section.visibilityExpression!);
          var evaluator = const ExpressionEvaluator();

          final context = _buildContext();

          final result = evaluator.eval(exp, context);

          // ✅ تبدیل صحیح به bool
          bool newVisible = true;
          if (result is bool) {
            newVisible = result;
          } else if (result is num) {
            newVisible = result != 0;
          } else if (result is String) {
            newVisible = result.isNotEmpty && result.toLowerCase() != 'false';
          }

          if (sectionState.visible != newVisible) {
            sectionState.visible = newVisible;
            changed = true;
          }
        } catch (e) {
          print('خطا در section visibility: $e');
          print('Expression: ${section.visibilityExpression}');
        }
      }
    }

    // ✅ Fields رو evaluate کن
    for (final field in schema.allFields) {
      final id = field?.id;
      if (id == null) continue;
      final state = _fields[id];
      if (state == null) continue;

      // visibilityExpression
      if (field?.visibilityExpression != null) {
        try {
          final exp = Expression.parse(field!.visibilityExpression!);
          var evaluator = const ExpressionEvaluator();
          final context = _buildContext();
          final result = evaluator.eval(exp, context);

          // ✅ تبدیل صحیح به bool
          bool newVisible = true;
          if (result is bool) {
            newVisible = result;
          } else if (result is num) {
            newVisible = result != 0;
          } else if (result is String) {
            newVisible = result.isNotEmpty && result.toLowerCase() != 'false';
          }

          if (state.visible != newVisible) {
            state.visible = newVisible;
            changed = true;
          }
        } catch (e) {
          print('خطا در field visibility (${field!.id}): $e');
          print('Expression: ${field.visibilityExpression}');
        }
      }

      // enabled
      final newEnabled = isFieldEnabled(id);
      if (state.enabled != newEnabled) {
        state.enabled = newEnabled;
        changed = true;
      }

      // ❌ اینجا value رو null نکن! فقط مخفی کن
      // if (!state.visible) {
      //   state.value = null;
      //   state.errors = [];
      // }
    }

    if (changed) {
      _notifyListeners();
    }
  }

  // ✅ Helper method - بهبود یافته برای پردازش صحیح مقادیر
  Map<String, dynamic> _buildContext() {
    final context = <String, dynamic>{};
    for (var f in schema.allFields) {
      if (f != null) {
        final value = getValue(f.id);

        // اگر مقدار null است، از مقدار پیش‌فرض استفاده کن
        if (value == null) {
          // برای فیلدهای عددی/ارزی، پیش‌فرض را 0 بگذار تا expression ها نشکنند
          if (f is AppTextFieldModel && f.currency != null) {
            context[f.id] = 0;
          } else {
            context[f.id] = '';
          }
          continue;
        }

        // اگر مقدار String است
        if (value is String) {
          // برای فیلدهای currency، کاما را حذف کن و به عدد تبدیل کن
          if (f is AppTextFieldModel && f.currency != null) {
            final cleanValue = value.replaceAll(',', '').trim();
            context[f.id] = num.tryParse(cleanValue) ?? 0;
          } else {
            // سعی کن به عدد تبدیل کنی، اگر نشد همان String را نگه دار
            final numValue = num.tryParse(value.trim());
            context[f.id] = numValue ?? value;
          }
        } else if (value is num) {
          context[f.id] = value;
        } else if (value is bool) {
          context[f.id] = value;
        } else {
          context[f.id] = value;
        }
      }
    }
    return context;
  }

  void setValue(String id, dynamic value) {
    final state = _fields[id];
    if (state == null) return;

    state.value = value;
    evaluateAllConditionalFields();
    _evaluateExpressions();
    _notifyListeners();
  }



  /// return final JSON data
  Map<String, dynamic> toJson() {
    return {
      for (var key in _fields.keys) key: _fields[key]!.value
    };
  }


  void _evaluateExpressions() {
    bool changed = false;
    int iterations = 0;
    const maxIterations = 10;

    while (iterations < maxIterations) {
      iterations++;
      bool madeChange = false;

      for (final field in schema.allFields) {
        if (field?.expression == null) continue;
        if (field!.expression!.resultFieldId == field.id) continue;

        final state = _fields[field.id];
        if (state == null) continue;

        // ✅ اگر field مخفی است، محاسبه نکن
        if (!state.visible) continue;

        try {
          final exp = Expression.parse(field.expression!.expression);
          var evaluator = const ExpressionEvaluator();

          final context = _buildContext();
          final result = evaluator.eval(exp, context);

          // ✅ تبدیل نتیجه به فرمت مناسب
          String newValue;
          if (result is num) {
            // اگر عدد صحیح است، بدون اعشار نمایش بده
            if (result == result.toInt()) {
              newValue = result.toInt().toString();
            } else {
              newValue = result.toString();
            }
          } else {
            newValue = result.toString();
          }

          if (field.expression!.resultFieldId != null) {
            final resultField = _fields[field.expression!.resultFieldId];
            if (resultField != null && resultField.value != newValue) {
              resultField.value = newValue;
              madeChange = true;
              changed = true;
            }
          }
        } catch (e) {
          print('خطا در expression (${field.id}): $e');
          print('Expression: ${field.expression!.expression}');
        }
      }

      if (!madeChange) break;
    }

    if (changed) {
      _notifyListeners();
    }
  }


  List<String> validateField(FormFieldModel field) {
    final value = getValue(field.id);

    final state = _fields[field.id];
    if (state == null) return [];

    if (_isRequired(field) && _isEmptyValue(value)) {
      state.errors = ["این فیلد اجباری است"];
      _notifyListeners();
      return state.errors;
    }

    // ruleهای ValidationEngine
    final errors = ValidationEngine.validateField(field, value);

    state.errors = errors;
    _notifyListeners();
    return errors;
  }

  Map<String, List<String>> validateAll() {
    final result = <String, List<String>>{};

    for (final field in schema.allFields) {
      final currentField = field!;
      final value = getValue(currentField.id);
      if (_isRequired(currentField) && _isEmptyValue(value)) {
        const errors = ["این فیلد اجباری است"];
        _fields[currentField.id]?.errors = errors;
        result[currentField.id] = errors;
        continue;
      }

      final errors = ValidationEngine.validateField(field, value);

      _fields[currentField.id]?.errors = errors;

      if (errors.isNotEmpty) {
        result[currentField.id] = errors;
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

  bool _isRequired(FormFieldModel field) {
    final state = _fields[field.id];
    if (state != null && !state.visible) {
      return false;
    }
    if (field is AppTextFieldModel && field.isRequired == true) {
      return true;
    }
    return isFieldRequired(field.id);
  }

  bool _isEmptyValue(dynamic value) {
    return value == null ||
        (value is String && value.trim().isEmpty) ||
        (value is List && value.isEmpty);
  }

}

