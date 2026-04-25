
import 'padding.dart';

class FormSectionPaddingAll extends FormSectionPadding{
  final double? value;

  FormSectionPaddingAll({this.value});

  factory FormSectionPaddingAll.fromJson(Map<String, dynamic> json) {
    return FormSectionPaddingAll(value: json['value']);
  }

  Map<String, dynamic> toJson() => {'value': value};
}
