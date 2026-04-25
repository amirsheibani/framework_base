import 'package:flutter/material.dart';
import 'package:framework_base/packages/framework_enterprise_form_engine/lib/src/registry/section/section_registry.dart';
import '../core/form_schema.dart';
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
  @override
  void initState() {
    super.initState();

    // دیگر initWithSchema لازم نیست
    // controller خودش داخل constructor مقداردهی شده
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.addListener(() {
      setState(() {});
    });

    return _buildSections();

  }

  Widget _buildSections() {

    List<Widget>? widgetsSection = [];

    for (var section in widget.schema.sections) {
      Widget? child;
      if(section.fields?.isNotEmpty ?? false){
        final List<Widget> _widgetsSection = [];
        for (var field in section.fields ?? []) {
          final fieldWidget = FieldRegistry.build(context, field, widget.controller);
          _widgetsSection.add(Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: fieldWidget));
        }
        child = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: _widgetsSection,
        );
      }
      widgetsSection.add(SectionRegistry.build(context, section, widget.controller,child: child));
    }

    return  SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgetsSection,
      ),
    );
  }
}
