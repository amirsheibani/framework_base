import 'package:flutter/material.dart' as flutter_widget;
import 'package:framework_base/framework_base.dart';

import '../../core/form_field/form_field_model.dart';
import '../../registry/field/field_renderer.dart';
import '../../state/form_field_state.dart';

class AppTextFieldRenderer extends FieldRenderer {
  @override
  flutter_widget.Widget render(flutter_widget.BuildContext context, FormFieldModel field, FormFieldState state, FormStateController controller) {
    // اگر فیلد مخفی است، نمایش داده نشود
    if (!state.visible) {
      return const flutter_widget.SizedBox.shrink();
    }

    final hasError = state.errors.isNotEmpty;
    final textValue = state.value?.toString() ?? "";

    // اگر controller نیست، درست کنید
    if (state.textController == null) {
      state.textController = flutter_widget.TextEditingController(text: textValue)
        ..selection = flutter_widget.TextSelection.collapsed(offset: textValue.length);
    } else {
      // اگر state.value تغییر کرد (مثلاً از expression)، به‌روز کنید
      if (state.textController?.text != textValue) {
        state.textController?.text = textValue;
        state.textController?.selection = flutter_widget.TextSelection.collapsed(offset: textValue.length);
      }
    }

    // کنترلر reactive (سینک با state)

    if(field is AppTextFieldModel) {
      return AppTextFormField(
        controller: state.textController,
        type: field.type,
        size: field.size,
        currency: field.currency,
        label: field.label,
        value: field.value,
        hint: field.hint,
        helperText: field.helperText,
        isRequired: (field.isRequired ?? false) || controller.isFieldRequired(field.id),
        enabled: (field.enabled ?? true) && state.enabled,
        readOnly: field.readOnly ?? false,
        error: hasError ? state.errors.first : null,
        onChanged: (value) {
          state.debounceHelper(() {
            controller.setValue(field.id, value);
            controller.validateField(field);
          });
        },
      );
    }else{
      return const flutter_widget.Placeholder();
    }
  }
}
