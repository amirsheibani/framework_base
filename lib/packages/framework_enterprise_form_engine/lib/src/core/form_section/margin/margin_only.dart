import 'margin.dart';

class FormSectionMarginOnly extends FormSectionMargin {
  final double? marginRight;
  final double? marginTop;
  final double? marginLeft;
  final double? marginBottom;

  FormSectionMarginOnly({this.marginTop, this.marginLeft, this.marginBottom, this.marginRight});

  factory FormSectionMarginOnly.fromJson(Map<String, dynamic> json) {
    double? readNum(dynamic v) => (v is num) ? v.toDouble() : null;

    // supports:
    // - marginTop/marginLeft/... (form_schema-like)
    // - top/left/... (data.json-like)
    return FormSectionMarginOnly(
      marginTop: readNum(json['marginTop'] ?? json['top']),
      marginLeft: readNum(json['marginLeft'] ?? json['left']),
      marginBottom: readNum(json['marginBottom'] ?? json['bottom']),
      marginRight: readNum(json['marginRight'] ?? json['right']),
    );
  }

  Map<String, dynamic> toJson() => {
        'marginTop': marginTop,
        'marginLeft': marginLeft,
        'marginBottom': marginBottom,
        'marginRight': marginRight,
      };
}

