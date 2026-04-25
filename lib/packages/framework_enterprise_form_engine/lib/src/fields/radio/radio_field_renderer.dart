import 'package:flutter/material.dart' as flutter_widget;

import '../../core/form_field.dart';
import '../../registry/field/field_renderer.dart';
import '../../state/form_field_state.dart';
import '../../state/form_state_controller.dart';

class RadioFieldRenderer extends FieldRenderer {
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

    final options = field.options ?? [];
    final selectedValue = state.value;
    final hasError = state.errors.isNotEmpty;

    return flutter_widget.Column(
      crossAxisAlignment: flutter_widget.CrossAxisAlignment.start,
      children: [
        if (field.label != null)
          flutter_widget.Padding(
            padding: const flutter_widget.EdgeInsets.only(bottom: 6),
            child: flutter_widget.Text(
              field.label!,
              style: const flutter_widget.TextStyle(
                fontWeight: flutter_widget.FontWeight.bold,
              ),
            ),
          ),

        // لیست گزینه‌ها
        ...options.map((o) {
          return flutter_widget.RadioListTile<dynamic>(
            title: flutter_widget.Text(o.toString()),
            value: o,
            groupValue: selectedValue,
            onChanged: state.enabled
                ? (value) => controller.setValue(field.name, value)
                : null,
          );
        }).toList(),

        // نمایش خطا
        if (hasError)
          flutter_widget.Padding(
            padding: const flutter_widget.EdgeInsets.only(top: 4),
            child: flutter_widget.Text(
              state.errors.first,
              style: const flutter_widget.TextStyle(
                color: flutter_widget.Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
