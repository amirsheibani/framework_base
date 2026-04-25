import 'package:flutter/widgets.dart' as flutter_widget;


import '../../core/form_section/form_section.dart';
import '../../core/form_section/padding/padding_all.dart';
import '../../core/form_section/padding/padding_horizontal.dart';
import '../../core/form_section/padding/padding_only.dart';
import '../../core/form_section/padding/padding_vertical.dart';
import '../../registry/section/section_renderer.dart';
import '../../state/form_section_state.dart';


class PaddingSectionRenderer extends SectionRenderer {
  PaddingSectionRenderer(flutter_widget.Widget? child) : super(child: child);

  @override
  flutter_widget.Widget render(flutter_widget.BuildContext context, FormSectionModel section, FormSectionState state) {
    if (!(state.visible)) {
      return const flutter_widget.SizedBox.shrink();
    }
    return flutter_widget.Padding(
      padding: () {
        if (section.padding is FormSectionPaddingAll) {
          return flutter_widget.EdgeInsets.all((section.padding as FormSectionPaddingAll).value ?? 0.0);
        } else if (section.padding is FormSectionPaddingVertical) {
          return flutter_widget.EdgeInsets.symmetric(vertical: (section.padding as FormSectionPaddingAll).value ?? 0.0);
        } else if (section.padding is FormSectionPaddingHorizontal) {
          return flutter_widget.EdgeInsets.symmetric(horizontal: (section.padding as FormSectionPaddingAll).value ?? 0.0);
        } else if (section.padding is FormSectionPaddingOnly) {
          return flutter_widget.EdgeInsets.only(
            left: (section.padding as FormSectionPaddingOnly).paddingLeft ?? 0.0,
            right: (section.padding as FormSectionPaddingOnly).paddingRight ?? 0.0,
            top: (section.padding as FormSectionPaddingOnly).paddingTop ?? 0.0,
            bottom: (section.padding as FormSectionPaddingOnly).paddingBottom ?? 0.0,
          );
        }else{
          return flutter_widget.EdgeInsets.zero;
        }
      }(),
      child: child,
    );
  }
}
