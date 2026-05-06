import 'package:flutter/material.dart' as flutter_widget;
import 'package:framework_base/packages/framework_enterprise_form_engine/lib/src/core/form_section/form_section.dart';
import 'package:framework_base/packages/framework_enterprise_form_engine/lib/src/state/form_section_state.dart';


import '../../registry/section/section_renderer.dart';


class SizedBoxSectionRenderer extends SectionRenderer {
  SizedBoxSectionRenderer(flutter_widget.Widget? child) : super(child: child);
  @override
  flutter_widget.Widget render(flutter_widget.BuildContext context, FormSectionModel section, FormSectionState state, {flutter_widget.Widget? child}) {
    if (!state.visible) {
      return const flutter_widget.SizedBox.shrink();
    }

    return flutter_widget.SizedBox(width: section.width, height: section.height,child: child,);
  }
}
