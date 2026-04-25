import 'package:flutter/material.dart' as flutter_widget;

import '../../core/form_field.dart';
import '../../registry/field/field_renderer.dart';
import '../../state/form_field_state.dart';
import '../../state/form_state_controller.dart';

class EmailFieldRenderer extends FieldRenderer {
  @override
  flutter_widget.Widget render(
      flutter_widget.BuildContext context,
      FormFieldModel field,
      FormFieldState state,
      FormStateController controller,
      ) {
    // اگر فیلد مخفی باشد UI حذف شود
    if (!state.visible) {
      return const flutter_widget.SizedBox.shrink();
    }

    final hasError = state.errors.isNotEmpty;

    return flutter_widget.TextFormField(
      // مقدار واقعی از state گرفته می‌شود، نه initialValue
      controller: flutter_widget.TextEditingController(text: state.value?.toString() ?? "")
        ..selection = flutter_widget.TextSelection.collapsed(
          offset: (state.value?.toString() ?? "").length,
        ),

      keyboardType: flutter_widget.TextInputType.emailAddress,
      enabled: state.enabled,

      decoration: flutter_widget.InputDecoration(
        labelText: field.label,
        errorText: hasError ? state.errors.first : null,
      ),

      onChanged: (value) {
        controller.setValue(field.name, value);
      },
    );
  }
}
