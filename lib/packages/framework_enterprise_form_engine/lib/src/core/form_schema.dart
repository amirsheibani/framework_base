import 'form_field/form_field_model.dart';
import 'form_section/form_section.dart';
import 'form_section/padding/padding.dart';
import 'form_section/padding/padding_all.dart';
import 'form_section/padding/padding_horizontal.dart';
import 'form_section/padding/padding_only.dart';
import 'form_section/padding/padding_vertical.dart';

class FormSchema {
  final String id;
  final int version;
  final String title;
  final FormSectionModel? child;
  final FormSectionPadding? sectionsPadding;

  FormSchema({
    required this.id,
    required this.version,
    this.title = '',
    this.child,
    this.sectionsPadding,
  });

  List<FormFieldModel?> get allFields =>
      child == null ? const [] : _flattenFields([child!]);
  List<FormSectionModel> get allSections =>
      child == null ? const [] : _flattenSections([child!]);

  List<FormFieldModel?> _flattenFields(List<FormSectionModel> items) {
    final fields = <FormFieldModel?>[];
    for (final section in items) {
      if (section.field != null) {
        fields.add(section.field);
      }
      if (section.child != null) {
        fields.addAll(_flattenFields([section.child!]));
      }
      fields.addAll(_flattenFields(section.children ?? const []));
    }
    return fields;
  }

  List<FormSectionModel> _flattenSections(List<FormSectionModel> items) {
    final sections = <FormSectionModel>[];
    for (final section in items) {
      sections.add(section);
      if (section.child != null) {
        sections.addAll(_flattenSections([section.child!]));
      }
      sections.addAll(_flattenSections(section.children ?? const []));
    }
    return sections;
  }

  factory FormSchema.fromJson(Map<String, dynamic> json) {
    return FormSchema(
      id: json['id'],
      version: json['version'],
      title: json['title'] as String? ?? '',
      child: json['child'] != null ? FormSectionModel.fromJson(json['child']) : null,
      sectionsPadding: () {
        if (json['sections_padding_all'] != null) {
          return FormSectionPaddingAll(value: json['sections_padding_all']);
        } else if (json['sections_padding_horizontal'] != null) {
          return FormSectionPaddingHorizontal(value: json['sections_padding_horizontal']);
        } else if (json['sections_padding_vertical'] != null) {
          return FormSectionPaddingVertical(value: json['sections_padding_vertical']);
        } else if (json['sections_padding_only'] != null) {
          return FormSectionPaddingOnly.fromJson(json['sections_padding_only']);
        } else {
          return null;
        }
      }(),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'id': id,
      'version': version,
    };

    if (title.isNotEmpty) {
      map['title'] = title;
    }
    if (child != null) {
      map['child'] = child!.toJson();
    }

    final p = sectionsPadding;
    if (p != null) {
      if (p is FormSectionPaddingAll) {
        map['sections_padding_all'] = p.value;
      } else if (p is FormSectionPaddingVertical) {
        map['sections_padding_vertical'] = p.value;
      } else if (p is FormSectionPaddingHorizontal) {
        map['sections_padding_horizontal'] = p.value;
      } else if (p is FormSectionPaddingOnly) {
        map['sections_padding_only'] = p.toJson();
      }
    }

    return map;
  }
}
