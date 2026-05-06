// import 'package:flutter/material.dart' as flutter_widget;
// import '../../core/form_field.dart';
// import '../../registry/field/field_renderer.dart';
// import '../../state/form_field_state.dart';
// import '../../state/form_state_controller.dart';
//
// class DateFieldRenderer extends FieldRenderer {
//   @override
//   flutter_widget.Widget render(
//       flutter_widget.BuildContext context,
//       FormFieldModel field,
//       FormFieldState state,
//       FormStateController controller,
//       ) {
//     if (!state.visible) {
//       return const flutter_widget.SizedBox.shrink();
//     }
//
//     DateTime? selected;
//     final raw = state.value;
//
//     if (raw is DateTime) {
//       selected = raw;
//     } else if (raw is String) {
//       try {
//         selected = DateTime.tryParse(raw);
//       } catch (_) {}
//     }
//
//     final hasError = state.errors.isNotEmpty;
//
//     return flutter_widget.GestureDetector(
//       onTap: state.enabled
//           ? () async {
//         final picked = await flutter_widget.showDatePicker(
//           context: context,
//           initialDate: selected ?? DateTime.now(),
//           firstDate: DateTime(1900),
//           lastDate: DateTime(2100),
//         );
//
//         if (picked != null) {
//           controller.setValue(field.name, picked);
//         }
//       }
//           : null,
//       child: flutter_widget.InputDecorator(
//         decoration: flutter_widget.InputDecoration(
//           labelText: field.label,
//           enabled: state.enabled,
//           errorText: hasError ? state.errors.first : null,
//         ),
//         child: flutter_widget.Text(
//           selected != null
//               ? "${selected.year}-${selected.month.toString().padLeft(2, '0')}-${selected.day.toString().padLeft(2, '0')}"
//               : "انتخاب کنید",
//         ),
//       ),
//     );
//   }
// }
