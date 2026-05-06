import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as flutter_widget;
import 'package:framework_base/framework_base.dart';
import 'package:framework_base/packages/framework_enterprise_form_engine/lib/src/core/form_section/padding/padding_horizontal.dart';
import 'package:framework_base/packages/framework_enterprise_form_engine/lib/src/core/form_section/padding/padding_only.dart';


import '../../core/form_section/border_radius/border_radius_all.dart';
import '../../core/form_section/border_radius/border_radius_crcular.dart';
import '../../core/form_section/border_radius/border_radius_only.dart';
import '../../core/form_section/form_section.dart';
import '../../core/form_section/padding/padding_all.dart';
import '../../core/form_section/padding/padding_vertical.dart';
import '../../registry/section/section_renderer.dart';
import '../../state/form_section_state.dart';


class ContainerSectionRenderer extends SectionRenderer {
  ContainerSectionRenderer(flutter_widget.Widget? child) : super(child: child);

  @override
  flutter_widget.Widget render(flutter_widget.BuildContext context, FormSectionModel section, FormSectionState state) {
    if (!(state.visible)) {
      return const flutter_widget.SizedBox.shrink();
    }

    final hasTitle = section.title.trim().isNotEmpty;
    final Widget? contentChild = child;

    final Widget? composedChild = (hasTitle || contentChild != null)
        ? flutter_widget.Column(
            crossAxisAlignment: flutter_widget.CrossAxisAlignment.start,
            mainAxisSize: flutter_widget.MainAxisSize.min,
            children: [
              if (hasTitle)
                flutter_widget.Padding(
                  padding: const flutter_widget.EdgeInsets.only(bottom: 12),
                  child: AppText(
                    section.title,
                    selectedType: TextSelectedType.nonSelectable,
                    textAlign: flutter_widget.TextAlign.start,
                    style: section.titleStyle?.getStyle(
                          context,
                          section.titleColor?.hexToColor,
                        ) ??
                        flutter_widget.Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              if (contentChild != null) contentChild,
            ],
          )
        : null;

    return flutter_widget.Container(
      padding: section.padding != null ? () {
        if (section.padding is FormSectionPaddingAll) {
          return EdgeInsets.all((section.padding as FormSectionPaddingAll).value ?? 0.0);
        } else if (section.padding is FormSectionPaddingVertical) {
          return EdgeInsets.symmetric(vertical: (section.padding as FormSectionPaddingVertical).value ?? 0.0);
        } else if (section.padding is FormSectionPaddingHorizontal) {
          return EdgeInsets.symmetric(horizontal: (section.padding as FormSectionPaddingHorizontal).value ?? 0.0);
        } else if (section.padding is FormSectionPaddingOnly) {
          return EdgeInsets.only(
            left: (section.padding as FormSectionPaddingOnly).paddingLeft ?? 0.0,
            right: (section.padding as FormSectionPaddingOnly).paddingRight ?? 0.0,
            top: (section.padding as FormSectionPaddingOnly).paddingTop ?? 0.0,
            bottom: (section.padding as FormSectionPaddingOnly).paddingBottom ?? 0.0,
          );
        }
      }() : null,
      width: section.width,
      height: section.height,
      decoration: flutter_widget.BoxDecoration(
        color: section.decoration?.color,
        borderRadius: () {
          if (section.decoration?.formDecorationBorderRadius is FormDecorationBorderRadiusAll) {
            return flutter_widget.BorderRadius.all(flutter_widget.Radius.circular((section.decoration?.formDecorationBorderRadius as FormDecorationBorderRadiusAll).borderRadius ?? 0.0));
          } else if (section.decoration?.formDecorationBorderRadius is FormDecorationBorderRadiusOnly) {
            return flutter_widget.BorderRadius.only(
              topLeft: flutter_widget.Radius.circular((section.decoration?.formDecorationBorderRadius as FormDecorationBorderRadiusOnly).borderRadiusTopLeft ?? 0.0),
              topRight: flutter_widget.Radius.circular((section.decoration?.formDecorationBorderRadius as FormDecorationBorderRadiusOnly).borderRadiusTopRight ?? 0.0),
              bottomLeft: flutter_widget.Radius.circular((section.decoration?.formDecorationBorderRadius as FormDecorationBorderRadiusOnly).borderRadiusBottomLeft ?? 0.0),
              bottomRight: flutter_widget.Radius.circular((section.decoration?.formDecorationBorderRadius as FormDecorationBorderRadiusOnly).borderRadiusBottomRight ?? 0.0),
            );
          } else if (section.decoration?.formDecorationBorderRadius is FormDecorationBorderRadiusCircular) {
            return flutter_widget.BorderRadius.circular((section.decoration?.formDecorationBorderRadius as FormDecorationBorderRadiusCircular).borderRadius ?? 0.0);
          } else {
            return null;
          }
        }(),
      ),
      child: composedChild,
    );
  }
}
