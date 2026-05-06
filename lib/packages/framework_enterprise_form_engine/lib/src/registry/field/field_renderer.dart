import 'package:flutter/widgets.dart' as flutter;


import '../../core/form_field/form_field_model.dart';
import '../../state/form_state_controller.dart';
import '../../state/form_field_state.dart';


/// Base class for all field renderers.
/// Each renderer must implement the `render` method.
abstract class FieldRenderer {
  flutter.Widget render(flutter.BuildContext context, FormFieldModel field, FormFieldState state, FormStateController controller);
}
