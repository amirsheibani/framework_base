import 'package:framework_base/packages/framework_form/lib/form_framework.dart';

final class FormModel{
  final String? name;
  final String? value;



  FormModel({this.name,this.value});

  factory FormModel.fromJson(Map<String, dynamic> json) {
    return FormModel(
      name: json['name'] as String?,
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
    };
  }
}

