
import 'padding.dart';

class FormSectionPaddingOnly extends FormSectionPadding{
  final double? paddingRight;
  final double? paddingTop;
  final double? paddingLeft;
  final double? paddingBottom;


  FormSectionPaddingOnly({this.paddingTop, this.paddingLeft, this.paddingBottom, this.paddingRight});

  factory FormSectionPaddingOnly.fromJson(Map<String, dynamic> json) {
    double? readNum(dynamic v) => (v is num) ? v.toDouble() : null;

    return FormSectionPaddingOnly(
      // supports both:
      // - form_schema.json style: paddingTop/paddingLeft/...
      // - data.json style: top/left/...
      paddingTop: readNum(json['paddingTop'] ?? json['top']),
      paddingLeft: readNum(json['paddingLeft'] ?? json['left']),
      paddingBottom: readNum(json['paddingBottom'] ?? json['bottom']),
      paddingRight: readNum(json['paddingRight'] ?? json['right']),
    );
  }

  Map<String, dynamic> toJson() => {'paddingTop': paddingTop,'paddingLeft':paddingLeft,'paddingBottom':paddingBottom,'paddingRight':paddingRight};
}
