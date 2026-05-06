// import 'package:flutter/material.dart' as flutter_widget;
//
// import '../../core/form_field.dart';
// import '../../registry/field/field_renderer.dart';
// import '../../state/form_field_state.dart';
// import '../../state/form_state_controller.dart';
//
// class FileFieldRenderer extends FieldRenderer {
//   @override
//   flutter_widget.Widget render(
//       flutter_widget.BuildContext context,
//       FormFieldModel field,
//       FormFieldState state,
//       FormStateController controller,
//       ) {
//     // اگر فیلد مخفی باشد، اصلاً نمایش داده نشود
//     if (!state.visible) {
//       return const flutter_widget.SizedBox.shrink();
//     }
//
//     final hasError = state.errors.isNotEmpty;
//
//     return flutter_widget.Column(
//       crossAxisAlignment: flutter_widget.CrossAxisAlignment.start,
//       children: [
//         flutter_widget.ElevatedButton(
//           onPressed: state.enabled
//               ? () async {
//             // TODO: بعداً با file_picker جایگزین شود
//             const simulatedTestFile = "file_selected_test.txt";
//
//             controller.setValue(field.name, simulatedTestFile);
//           }
//               : null, // غیرفعال کردن دکمه
//           child: flutter_widget.Text(
//             state.value?.toString() ?? (field.label ?? "Select File"),
//           ),
//         ),
//
//         // نمایش خطا (اگر وجود داشت)
//         if (hasError)
//           flutter_widget.Padding(
//             padding: const flutter_widget.EdgeInsets.only(top: 6),
//             child: flutter_widget.Text(
//               state.errors.first,
//               style: const flutter_widget.TextStyle(
//                 color: flutter_widget.Colors.red,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
