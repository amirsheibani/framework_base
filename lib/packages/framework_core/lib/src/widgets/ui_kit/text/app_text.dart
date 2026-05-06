import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:framework_base/packages/framework_core/lib/src/widgets/ui_kit/text/text_formater/card_number_formatter.dart';
import 'package:framework_base/packages/framework_core/lib/src/widgets/ui_kit/text/text_formater/currency_formatter.dart';
import 'package:framework_base/packages/framework_core/lib/src/widgets/ui_kit/text/text_formater/date_formatter.dart';
import 'package:framework_base/packages/framework_core/lib/src/widgets/ui_kit/text/text_formater/iban_formatter.dart';
import 'package:framework_base/packages/framework_core/lib/src/widgets/ui_kit/text/text_formater/phone_formatter.dart';

enum TextSelectedType { selectable, nonSelectable }

enum AppTextType { text, password, email, phone, address, date, currency, iban, cardNumber, textMultiline, dropdown }

typedef SelectionChangedCallback = void Function(TextSelection selection, SelectionChangedCause? cause);

class AppText extends StatelessWidget {
  final TextSelectedType selectedType;
  final AppTextType appTextType;
  final String data;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final String? semanticsIdentifier;
  final TextWidthBasis? textWidthBasis;
  final SelectionChangedCallback? onSelectionChanged;

  const AppText(
    this.data, {
    super.key,
    this.selectedType = TextSelectedType.selectable,
    this.appTextType = AppTextType.text,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.semanticsIdentifier,
    this.textWidthBasis,
    this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return selectedType == TextSelectedType.nonSelectable
        ? Text(
            () {
              return switch (appTextType) {
                AppTextType.text => data,
                AppTextType.password => data,
                AppTextType.email => data,
                AppTextType.phone => data.formatPhone,
                AppTextType.address => data,
                AppTextType.date => data.formatDate,
                AppTextType.currency => data.formatCurrency,
                AppTextType.iban => data.formatIBAN,
                AppTextType.cardNumber => data.formatCardNumber,
                AppTextType.textMultiline => data,
                AppTextType.dropdown => data,
              };
            }(),
            style: style,
            strutStyle: strutStyle,
            textAlign: textAlign,
            textDirection: textDirection,
            locale: locale,
            softWrap: softWrap,
            overflow: overflow,
            textScaler: textScaler,
            maxLines: maxLines,
            semanticsLabel: semanticsLabel,
            semanticsIdentifier: semanticsIdentifier,
            textWidthBasis: textWidthBasis,
          )
        : SelectableText(
            () {
              return switch (appTextType) {
                AppTextType.text => data,
                AppTextType.password => data,
                AppTextType.email => data,
                AppTextType.phone => data.formatPhone,
                AppTextType.address => data,
                AppTextType.date => data.formatDate,
                AppTextType.currency => data.formatCurrency,
                AppTextType.iban => data.formatIBAN,
                AppTextType.cardNumber => data.formatCardNumber,
                AppTextType.textMultiline => data,
                AppTextType.dropdown => data,
              };
            }(),
            style: style,
            strutStyle: strutStyle,
            textAlign: textAlign,
            textDirection: textDirection,
            textScaler: textScaler,
            maxLines: maxLines,
            semanticsLabel: semanticsLabel,
            textWidthBasis: textWidthBasis,
            onSelectionChanged: onSelectionChanged,
          );
  }
}
