
import 'package:flutter/widgets.dart';


import '../../core/field_type.dart';
import '../../core/form_field/form_field_model.dart';
import '../../state/form_state_controller.dart';
import 'field_renderer.dart';

class FieldRegistry {
  static final Map<FieldType, FieldRenderer> _renderers = {};

  /// Registers a renderer instance for a specific field type
  static void register(FieldType type, FieldRenderer renderer) {
    _renderers[type] = renderer;
  }

  /// Builds the widget for a given field
  static Widget build(
      BuildContext context,
      FormFieldModel field,
      FormStateController controller,
      ) {
    final FieldType type = FieldType.values.firstWhere((item) => item == field.fieldType);
    final renderer = _renderers[type];

    if (renderer == null) {
      return Text("No renderer registered for ${type.name}");
    }


    final  state = controller.getFieldState(field.id);
    if (state == null) {
      return Text("No state found for field '${field.id}'");
    }

    return renderer.render(context, field, state, controller);
  }

  /// Checks if this field type has a renderer
  static bool supports(FieldType type) {
    return _renderers.containsKey(type);
  }
}
