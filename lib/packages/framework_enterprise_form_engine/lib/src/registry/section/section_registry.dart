
import 'package:flutter/widgets.dart';
import 'package:framework_base/packages/framework_enterprise_form_engine/lib/src/state/form_section_state.dart';


import '../../core/field_type.dart';
import '../../core/form_field.dart';
import '../../core/form_section/form_section.dart';
import '../../core/form_section/section_type.dart';
import '../../state/form_state_controller.dart';
import '../field/field_registry.dart';
import 'section_renderer.dart';
typedef SectionRendererBuilder = SectionRenderer Function(Widget? child);

class SectionRegistry {
  static final Map<SectionType, SectionRendererBuilder> _renderers = {};


  /// Registers a renderer instance for a specific field type
  static void register(SectionType type,  SectionRendererBuilder sectionRendererBuilder) {
    _renderers[type] = sectionRendererBuilder;
  }

  /// Builds the widget for a given field
  static Widget build(
      BuildContext context,
      FormSectionModel section,
      FormStateController controller,
      {Widget? child}) {
    final renderer = _renderers[section.type];

    if (renderer == null) {
      return Text("No renderer registered for ${section.type}");
    }

    final  state = controller.getSectionState(section.title);
    if (state == null) {
      return Text("No state found for section '${section.title}'");
    }

    return renderer(child).render(context, section, state);
  }

  /// Checks if this field type has a renderer
  static bool supports(SectionType type) {
    return _renderers.containsKey(type);
  }
}


// typedef RuleBuilder = ValidationRuleBase Function(Map<String, dynamic>? config);
//
// class ValidationRegistry {
//   static final Map<RuleFieldType, RuleBuilder> _builders = {};
//
//   static void register(RuleFieldType type, RuleBuilder builder) {
//     _builders[type] = builder;
//   }
//
//   static ValidationRuleBase create(RuleFieldType type, Map<String, dynamic>? config) {
//     final builder = _builders[type];
//     if (builder == null) {
//       throw Exception("Validation rule '$type' is not registered in ValidationRegistry.");
//     }
//     return builder(config);
//   }
// }
