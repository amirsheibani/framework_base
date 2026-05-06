
import 'package:flutter/widgets.dart';

import '../../core/form_section/form_section.dart';
import '../../core/form_section/margin/margin_all.dart';
import '../../core/form_section/margin/margin_horizontal.dart';
import '../../core/form_section/margin/margin_only.dart';
import '../../core/form_section/margin/margin_vertical.dart';
import '../../core/form_section/section_type.dart';
import '../../state/form_state_controller.dart';
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

    final state = controller.getSectionState(section.id);
    if (state == null) {
      return Text("No state found for section '${section.id}'");
    }

    final built = renderer(child).render(context, section, state);

    final margin = section.margin;
    if (margin == null) return built;

    EdgeInsets toEdgeInsets() {
      if (margin is FormSectionMarginAll) {
        return EdgeInsets.all(margin.value ?? 0.0);
      } else if (margin is FormSectionMarginVertical) {
        return EdgeInsets.symmetric(vertical: margin.value ?? 0.0);
      } else if (margin is FormSectionMarginHorizontal) {
        return EdgeInsets.symmetric(horizontal: margin.value ?? 0.0);
      } else if (margin is FormSectionMarginOnly) {
        return EdgeInsets.only(
          left: margin.marginLeft ?? 0.0,
          right: margin.marginRight ?? 0.0,
          top: margin.marginTop ?? 0.0,
          bottom: margin.marginBottom ?? 0.0,
        );
      }
      return EdgeInsets.zero;
    }

    return Padding(padding: toEdgeInsets(), child: built);
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
