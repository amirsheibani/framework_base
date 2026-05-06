import 'package:flutter/widgets.dart' as flutter_widget;

import '../../core/form_section/form_section.dart';
import '../../registry/section/section_renderer.dart';
import '../../state/form_section_state.dart';

class ColumnSectionRenderer extends SectionRenderer {
  ColumnSectionRenderer(flutter_widget.Widget? child) : super(child: child);

  @override
  flutter_widget.Widget render(
    flutter_widget.BuildContext context,
    FormSectionModel section,
    FormSectionState state,
  ) {
    if (!state.visible) {
      return const flutter_widget.SizedBox.shrink();
    }

    return flutter_widget.SizedBox(
      width: section.width,
      height: section.height,
      child: child,
    );
  }
}
