// import 'package:flutter/material.dart' as flutter_widget;
// import '../../core/form_field.dart';
// import '../../registry/field/field_renderer.dart';
// import '../../state/form_field_state.dart';
// import '../../state/form_state_controller.dart';
//
// class DateTimeFieldRenderer extends FieldRenderer {
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
//
//     // Parse value from state
//     final raw = state.value;
//     if (raw is DateTime) {
//       selected = raw;
//     } else if (raw is String) {
//       selected = DateTime.tryParse(raw);
//     }
//
//     final hasError = state.errors.isNotEmpty;
//
//     String formatDateTime(DateTime dt) {
//       final y = dt.year;
//       final m = dt.month.toString().padLeft(2, '0');
//       final d = dt.day.toString().padLeft(2, '0');
//       final h = dt.hour.toString().padLeft(2, '0');
//       final min = dt.minute.toString().padLeft(2, '0');
//       return "$y-$m-$d  $h:$min";
//     }
//
//     return flutter_widget.GestureDetector(
//       onTap: state.enabled
//           ? () async {
//         //-----------------------
//         // 1) Pick Date
//         //-----------------------
//         final pickedDate = await flutter_widget.showDatePicker(
//           context: context,
//           initialDate: selected ?? DateTime.now(),
//           firstDate: DateTime(1900),
//           lastDate: DateTime(2100),
//         );
//
//         if (pickedDate == null) return;
//
//         //-----------------------
//         // 2) Pick Time
//         //-----------------------
//         final pickedTime = await flutter_widget.showTimePicker(
//           context: context,
//           initialTime: selected != null
//               ? flutter_widget.TimeOfDay(
//             hour: selected.hour,
//             minute: selected.minute,
//           )
//               : flutter_widget.TimeOfDay.now(),
//         );
//
//         if (pickedTime == null) return;
//
//         //-----------------------
//         // 3) Combine result
//         //-----------------------
//         final combined = DateTime(
//           pickedDate.year,
//           pickedDate.month,
//           pickedDate.day,
//           pickedTime.hour,
//           pickedTime.minute,
//         );
//
//         controller.setValue(field.name, combined);
//       }
//           : null,
//
//       child: flutter_widget.InputDecorator(
//         decoration: flutter_widget.InputDecoration(
//           labelText: field.label,
//           enabled: state.enabled,
//           errorText: hasError ? state.errors.first : null,
//         ),
//         child: flutter_widget.Text(
//           selected != null ? formatDateTime(selected) : "انتخاب کنید",
//         ),
//       ),
//     );
//   }
// }
