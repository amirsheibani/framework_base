// import 'package:flutter/material.dart' as flutter_widget;
//
// import '../../core/form_field.dart';
// import '../../registry/field/field_renderer.dart';
// import '../../state/form_field_state.dart';
// import '../../state/form_state_controller.dart';
//
// class TimeFieldRenderer extends FieldRenderer {
//   @override
//   flutter_widget.Widget render(
//       flutter_widget.BuildContext context,
//       FormFieldModel field,
//       FormFieldState state,
//       FormStateController controller,
//       ) {
//     // اگر فیلد مخفی است نمایش داده نشود
//     if (!state.visible) {
//       return const flutter_widget.SizedBox.shrink();
//     }
//
//     final hasError = state.errors.isNotEmpty;
//     final String displayValue =
//         state.value?.toString() ?? "انتخاب ساعت";
//
//     return flutter_widget.GestureDetector(
//       onTap: state.enabled
//           ? () async {
//         final picked = await flutter_widget.showTimePicker(
//           context: context,
//           initialTime: flutter_widget.TimeOfDay.now(),
//         );
//
//         if (picked != null) {
//           controller.setValue(field.name, picked.format(context));
//         }
//       }
//           : null,
//
//       child: flutter_widget.InputDecorator(
//         decoration: flutter_widget.InputDecoration(
//           labelText: field.label,
//           errorText: hasError ? state.errors.first : null,
//           enabled: state.enabled,
//         ),
//
//         child: flutter_widget.Text(
//           displayValue,
//           style: flutter_widget.TextStyle(
//             color: state.enabled
//                 ? flutter_widget.Colors.black
//                 : flutter_widget.Colors.grey,
//           ),
//         ),
//       ),
//     );
//   }
// }
