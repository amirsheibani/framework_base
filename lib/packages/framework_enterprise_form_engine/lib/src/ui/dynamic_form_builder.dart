import 'package:flutter/material.dart';
import 'package:framework_base/packages/framework_enterprise_form_engine/lib/src/registry/section/section_registry.dart';
import '../core/form_schema.dart';
import '../core/form_section/padding/padding_all.dart';
import '../core/form_section/padding/padding_horizontal.dart';
import '../core/form_section/padding/padding_only.dart';
import '../core/form_section/padding/padding_vertical.dart';
import '../core/form_section/form_section.dart';
import '../core/form_section/section_type.dart';
import '../state/form_state_controller.dart';
import '../registry/field/field_registry.dart';

class DynamicFormBuilder extends StatefulWidget {
  final FormSchema schema;
  final FormStateController controller;

  const DynamicFormBuilder({super.key, required this.schema, required this.controller});

  @override
  State<DynamicFormBuilder> createState() => _DynamicFormBuilderState();
}

class _DynamicFormBuilderState extends State<DynamicFormBuilder> {
  late final VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    _listener = () {
      setState(() {});
    };
    widget.controller.addListener(_listener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildSections();
  }

  Widget _buildSections() {
    EdgeInsets paddingToEdgeInsets(dynamic p) {
      if (p is FormSectionPaddingAll) {
        return EdgeInsets.all(p.value ?? 0.0);
      } else if (p is FormSectionPaddingVertical) {
        return EdgeInsets.symmetric(vertical: p.value ?? 0.0);
      } else if (p is FormSectionPaddingHorizontal) {
        return EdgeInsets.symmetric(horizontal: p.value ?? 0.0);
      } else if (p is FormSectionPaddingOnly) {
        return EdgeInsets.only(
          left: p.paddingLeft ?? 0.0,
          right: p.paddingRight ?? 0.0,
          top: p.paddingTop ?? 0.0,
          bottom: p.paddingBottom ?? 0.0,
        );
      }
      return EdgeInsets.zero;
    }

    final root = widget.schema.child;
    final list = root == null ? const SizedBox.shrink() : _buildSection(root);

    final wrapperPadding = widget.schema.sectionsPadding;
    final wrappedList = wrapperPadding == null ? list : Padding(padding: paddingToEdgeInsets(wrapperPadding), child: list);

    return SingleChildScrollView(child: wrappedList);
  }

  Widget _buildSection(FormSectionModel section) {
    final children = <Widget>[];

    final field = section.field;
    if (field != null) {
      final fieldWidget = FieldRegistry.build(context, field, widget.controller);
      final wrappedField = Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: fieldWidget,
      );
      children.add(wrappedField);
    }

    for (final childSection in section.children ?? const []) {
      final childWidget = _buildSection(childSection);
      children.add(childWidget);
    }

    Widget? child;
    if (section.child != null) {
      child = _buildSection(section.child!);
    } else if (children.isNotEmpty) {
      if (section.type == SectionType.row) {
        final row = Row(
          mainAxisAlignment: section.mainAxisAlignment ?? MainAxisAlignment.start,
          mainAxisSize: section.mainAxisSize ?? MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        );
        child = section.scroll
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: row,
              )
            : row;
      } else {
        final column = Column(
          mainAxisAlignment: section.mainAxisAlignment ?? MainAxisAlignment.start,
          mainAxisSize: section.mainAxisSize ?? MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        );
        child = section.scroll
            ? SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: column,
              )
            : column;
      }
    }

    return SectionRegistry.build(
      context,
      section,
      widget.controller,
      child: child,
    );
  }
}
