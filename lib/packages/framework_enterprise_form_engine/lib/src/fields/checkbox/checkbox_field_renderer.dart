// import 'package:flutter/material.dart' as flutter_widget;
//
// import '../../core/form_field.dart';
// import '../../core/form_field/form_field_model.dart';
// import '../../registry/field/field_renderer.dart';
// import '../../state/form_field_state.dart';
// import '../../state/form_state_controller.dart';

// class CheckboxFieldRenderer extends FieldRenderer {
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
//     final isChecked = state.value == true;
//     final hasError = state.errors.isNotEmpty;
//     final label = (field.label?.isNotEmpty ?? false)
//         ? field.label!
//         : field.name;
//
//     return flutter_widget.Column(
//       crossAxisAlignment: flutter_widget.CrossAxisAlignment.start,
//       children: [
//         flutter_widget.CheckboxListTile(
//           value: isChecked,
//           onChanged: state.enabled
//               ? (checked) =>
//               controller.setValue(field.name, checked ?? false)
//               : null,
//           title: flutter_widget.Text(label),
//           controlAffinity:
//           flutter_widget.ListTileControlAffinity.leading,
//         ),
//
//         if (hasError)
//           flutter_widget.Padding(
//             padding: const flutter_widget.EdgeInsets.only(left: 16, top: 4),
//             child: flutter_widget.Text(
//               state.errors.first,
//               style: flutter_widget.TextStyle(
//                 color: flutter_widget.Theme.of(context).colorScheme.error,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
