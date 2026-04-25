import 'package:flutter/material.dart' as flutter_widget;

import '../../core/form_field.dart';
import '../../registry/field/field_renderer.dart';
import '../../state/form_field_state.dart';
import '../../state/form_state_controller.dart';

class TextFieldRenderer extends FieldRenderer {
  @override
  flutter_widget.Widget render(
      flutter_widget.BuildContext context,
      FormFieldModel field,
      FormFieldState state,
      FormStateController controller,
      ) {
    // اگر فیلد مخفی است، نمایش داده نشود
    if (!state.visible) {
      return const flutter_widget.SizedBox.shrink();
    }

    final hasError = state.errors.isNotEmpty;
    final textValue = state.value?.toString() ?? "";

    // کنترلر reactive (سینک با state)
    final textController = flutter_widget.TextEditingController(text: textValue)
      ..selection = flutter_widget.TextSelection.collapsed(
        offset: textValue.length,
      );

    return flutter_widget.TextFormField(
      controller: textController,
      enabled: state.enabled,

      decoration: flutter_widget.InputDecoration(
        labelText: field.label,
        hintText: field.placeholder, // اگر در مدل اضافه‌اش کرده‌ای
        errorText: hasError ? state.errors.first : null,
      ),

      onChanged: (value) {
        controller.setValue(field.name, value);
      },
    );
  }
}
