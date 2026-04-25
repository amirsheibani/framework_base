
import 'border_radius.dart';

class FormDecorationBorderRadiusOnly extends FormDecorationBorderRadius {
  final double? borderRadiusTopLeft;
  final double? borderRadiusTopRight;
  final double? borderRadiusBottomLeft;
  final double? borderRadiusBottomRight;

  FormDecorationBorderRadiusOnly({this.borderRadiusTopLeft, this.borderRadiusTopRight, this.borderRadiusBottomLeft, this.borderRadiusBottomRight});

  factory FormDecorationBorderRadiusOnly.fromJson(Map<String, dynamic> json) {
    return FormDecorationBorderRadiusOnly(
      borderRadiusTopLeft: json['borderRadiusTopLeft'],
      borderRadiusTopRight: json['borderRadiusTopRight'],
      borderRadiusBottomLeft: json['borderRadiusBottomLeft'],
      borderRadiusBottomRight: json['borderRadiusBottomRight'],
    );
  }

  Map<String, dynamic> toJson() => {'borderRadiusTopLeft': borderRadiusTopLeft, 'borderRadiusTopRight': borderRadiusTopRight, 'borderRadiusBottomLeft': borderRadiusBottomLeft, 'borderRadiusBottomRight': borderRadiusBottomRight};
}