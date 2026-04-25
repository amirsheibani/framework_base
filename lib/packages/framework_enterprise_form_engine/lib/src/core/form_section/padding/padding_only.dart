
import 'padding.dart';

class FormSectionPaddingOnly extends FormSectionPadding{
  final double? paddingRight;
  final double? paddingTop;
  final double? paddingLeft;
  final double? paddingBottom;


  FormSectionPaddingOnly({this.paddingTop, this.paddingLeft, this.paddingBottom, this.paddingRight});

  factory FormSectionPaddingOnly.fromJson(Map<String, dynamic> json) {
    return FormSectionPaddingOnly(
        paddingTop: json['paddingTop'],
      paddingLeft: json['paddingLeft'],
      paddingBottom: json['paddingBottom'],
      paddingRight: json['paddingRight'],
    );
  }

  Map<String, dynamic> toJson() => {'paddingTop': paddingTop,'paddingLeft':paddingLeft,'paddingBottom':paddingBottom,'paddingRight':paddingRight};
}
