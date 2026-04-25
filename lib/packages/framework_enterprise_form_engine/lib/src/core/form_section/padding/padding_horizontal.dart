
import 'padding.dart';

class FormSectionPaddingHorizontal extends FormSectionPadding{
  final double? value;

  FormSectionPaddingHorizontal({this.value});

  factory FormSectionPaddingHorizontal.fromJson(Map<String, dynamic> json) {
    return FormSectionPaddingHorizontal(value: json['value']);
  }

  Map<String, dynamic> toJson() => {'value': value};
}
