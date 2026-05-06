import 'dart:ui';

import 'package:flutter/material.dart' as flutter_widget;
import 'package:framework_base/framework_base.dart';

import '../../core/form_field/form_field_model.dart';
import '../../registry/field/field_renderer.dart';
import '../../state/form_field_state.dart';

class AppTextRenderer extends FieldRenderer {
  @override
  flutter_widget.Widget render(flutter_widget.BuildContext context, FormFieldModel field, FormFieldState state, FormStateController controller) {
    if (!state.visible) {
      return const flutter_widget.SizedBox.shrink();
    }

    if(field is AppTextModel) {
      final textValue = state.value?.toString() ?? "";
      return AppText(
        textValue,
        selectedType: field.selectedType ?? TextSelectedType.selectable,
        appTextType: field.appTextType ?? AppTextType.text,
        style: field.style?.getStyle(context, field.color?.hexToColor),
        textAlign:field.textAlign,
        textDirection:field.textDirection,
        locale:field.locale != null ? Locale(field.locale!) : null,
        softWrap:field.softWrap,
        overflow:field.overflow,
        maxLines:field.maxLines,
        semanticsLabel:field.semanticsLabel,
        semanticsIdentifier:field.semanticsIdentifier,
        textWidthBasis:field.textWidthBasis,
      );
    }else{
      return const flutter_widget.Placeholder();
    }
  }
}
