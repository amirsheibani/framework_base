import 'package:flutter/widgets.dart' as flutter;


import '../../core/form_field.dart';
import '../../core/form_section/form_section.dart';
import '../../state/form_section_state.dart';
import '../../state/form_state_controller.dart';
import '../../state/form_field_state.dart';


/// Base class for all field renderers.
/// Each renderer must implement the `render` method.
abstract class SectionRenderer {
  flutter.Widget? child;

  SectionRenderer({this.child});

  flutter.Widget render(flutter.BuildContext context, FormSectionModel section,FormSectionState state);
}
