import 'form_section/form_section.dart';
import 'form_field.dart';

class FormSchema {
  final String id;
  final int version;
  final String title;
  final List<FormSectionModel> sections;

  FormSchema({
    required this.id,
    required this.version,
    required this.title,
    required this.sections,
  });

  List<FormFieldModel> get allFields => sections.expand<FormFieldModel>((section) => section.fields ?? []).toList();

  factory FormSchema.fromJson(Map<String, dynamic> json) {
    return FormSchema(
      id: json['id'],
      version: json['version'],
      title: json['title'],
      sections: (json['sections'] as List)
          .map((s) => FormSectionModel.fromJson(s))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'version': version,
    'title': title,
    'sections': sections.map((e) => e.toJson()).toList(),
  };
}


