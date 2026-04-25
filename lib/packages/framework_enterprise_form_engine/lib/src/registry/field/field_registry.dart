
import 'package:flutter/widgets.dart';


import '../../core/field_type.dart';
import '../../core/form_field.dart';
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
    final renderer = _renderers[field.type];

    if (renderer == null) {
      return Text("No renderer registered for ${field.type}");
    }


    final  state = controller.getFieldState(field.name);
    if (state == null) {
      return Text("No state found for field '${field.name}'");
    }

    return renderer.render(context, field, state, controller);
  }

  /// Checks if this field type has a renderer
  static bool supports(FieldType type) {
    return _renderers.containsKey(type);
  }
}
