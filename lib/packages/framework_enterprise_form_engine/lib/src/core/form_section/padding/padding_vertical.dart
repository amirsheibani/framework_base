
import 'padding.dart';

class FormSectionPaddingVertical extends FormSectionPadding{
  final double? value;

  FormSectionPaddingVertical({this.value});

  factory FormSectionPaddingVertical.fromJson(Map<String, dynamic> json) {
    return FormSectionPaddingVertical(value: json['value']);
  }

  Map<String, dynamic> toJson() => {'value': value};
}

