// import 'package:flutter/material.dart' as flutter_widget;
//
// import '../../core/form_field.dart';
// import '../../registry/field/field_renderer.dart';
// import '../../state/form_field_state.dart';
// import '../../state/form_state_controller.dart';
//
// class DropdownFieldRenderer extends FieldRenderer {
//   @override
//   flutter_widget.Widget render(
//       flutter_widget.BuildContext context,
//       FormFieldModel field,
//       FormFieldState state,
//       FormStateController controller,
//       ) {
//     // اگر فیلد مخفی باشد، کامل حذف شود
//     if (!state.visible) {
//       return const flutter_widget.SizedBox.shrink();
//     }
//
//     final value = state.value;
//     final options = field.options ?? [];
//     final hasError = state.errors.isNotEmpty;
//
//     // بررسی اینکه مقدار فعلی در لیست گزینه‌ها هست یا نه
//     final dropdownValue = options.contains(value) ? value : null;
//
//     return flutter_widget.DropdownButtonFormField(
//       value: dropdownValue,
//       decoration: flutter_widget.InputDecoration(
//         labelText: field.label,
//         enabled: state.enabled,
//         errorText: hasError ? state.errors.first : null,
//       ),
//       items: options
//           .map(
//             (o) => flutter_widget.DropdownMenuItem(
//           value: o,
//           child: flutter_widget.Text(o.toString()),
//         ),
//       )
//           .toList(),
//       onChanged: state.enabled
//           ? (selected) {
//         controller.setValue(field.name, selected);
//       }
//           : null,
//     );
//   }
// }
