import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:framework_base/framework_base.dart';
import 'package:hugeicons/hugeicons.dart';

import 'input_formatter/card_number_input_formatter.dart';
import 'input_formatter/currency_input_formatter.dart';
import 'input_formatter/date_input_formatter.dart';
import 'input_formatter/iban_input_formatter.dart';
import 'input_formatter/phone_input_formatter.dart';
import 'widget/password_helper.dart';

enum AppTextFormFieldType { text, password, email, phone, address, date, currency, iban, cardNumber, textMultiline, dropdown }

enum AppTextFormFieldSize { small, medium, large }

enum AppTextFormFieldCurrency {
  rial('ریال'),
  dollar('\$'),
  euro('€'),
  pound('£');

  final String value;

  const AppTextFormFieldCurrency(this.value);
}

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    super.key,
    this.size = AppTextFormFieldSize.large,
    this.type = AppTextFormFieldType.text,
    this.currency = AppTextFormFieldCurrency.rial,
    this.label,
    this.isRequired,
    this.controller,
    this.enabled = true,
    this.readOnly = false,
    this.hint,
    this.validator,
    this.helperText,
    this.labelTap,
    this.onTap,
    this.onSaved,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onChanged,
    this.autocorrect = false,
    this.enableSuggestions = false,
    this.suffixWidget,
    this.prefixWidget,
    this.onTapSuffix,
    this.onTapPrefix,
    this.onTapSuffixCurrency,
    this.onTapSuffixIban,
    this.autoFontResize = false,
    this.maxLength,
    this.showCharacterCount = false,
    this.value, this.error,
  });

  final AppTextFormFieldType type;
  final AppTextFormFieldSize size;
  final AppTextFormFieldCurrency? currency;
  final String? label;
  final String? hint;
  final String? helperText;
  final bool? isRequired;
  final bool enabled;
  final bool readOnly;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? labelTap;
  final VoidCallback? onTap;
  final ValueChanged<String?>? onSaved;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String?>? onFieldSubmitted;
  final ValueChanged<String?>? onChanged;
  final bool enableSuggestions;
  final bool autocorrect;
  final Widget? suffixWidget;
  final VoidCallback? onTapSuffix;
  final Widget? prefixWidget;
  final VoidCallback? onTapPrefix;
  final VoidCallback? onTapSuffixCurrency;
  final VoidCallback? onTapSuffixIban;
  final bool autoFontResize;
  final int? maxLength;
  final bool? showCharacterCount;
  final String? value;
  final String? error;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool isHovered = false;
  bool isFocused = false;
  bool hasError = false;
  bool obscureText = false;
  String? errorMessage;
  final FocusNode _focusNode = FocusNode();
  double minFontSize = 12.0;
  StreamController<String>? textStream;

  late TextStyle dynamicFontStyle;

  late TextEditingController _controller;
  bool _isInternalController = false;

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = TextEditingController(text: widget.value);
      _isInternalController = true;
    }

    if (widget.type == AppTextFormFieldType.password) {
      textStream = StreamController<String>.broadcast();
      _controller.addListener(() {
        textStream!.add(_controller.text);
      });
    }

    obscureText = widget.type == AppTextFormFieldType.password;
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
    _controller.addListener(_handleAutoResize);
  }


  @override
  void didUpdateWidget(AppTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != null && widget.controller != oldWidget.controller) {
      // اگر کنترلر خارجی تغییر کرده است
      _controller.text = widget.controller!.text;

      // اگر نیاز دارید عملیات خاصی انجام دهید، اینجا انجام دهید
      _handleAutoResize();

      // در صورت نیاز، وضعیت‌های دیگر را بروزرسانی کنید
    } else if (widget.controller != null && widget.controller!.text != _controller.text) {
      // اگر مقدار کنترلر خارجی تغییر می‌کند و خودش هم متفاوت است، هم‌نوا کنید
      _controller.text = widget.controller!.text;
    }

    _applyFormatters();
    // if(oldWidget.controller != widget.controller){
    //   if(widget.controller != null){
    //     _controller.text = widget.controller?.text ?? '';
    //   }
    // }
    if(widget.error != null){
      hasError = true;
      errorMessage = widget.error;
    }else{
      hasError = false;
    }
    dynamicFontStyle = _baseFontSize();

  }


  void _applyFormatters() {
    TextEditingValue value = _controller.value;

    final formatters = <TextInputFormatter>[
      if (widget.type == AppTextFormFieldType.cardNumber) CardNumberInputFormatter(),
      if (widget.type == AppTextFormFieldType.currency)
        CurrencyInputFormatter(isRial: widget.currency == AppTextFormFieldCurrency.rial),
      if (widget.type == AppTextFormFieldType.phone) PhoneInputFormatter(),
      if (widget.type == AppTextFormFieldType.iban) IBANInputFormatter(),
      if (widget.type == AppTextFormFieldType.date) DateInputFormatter(),
    ];

    for (final formatter in formatters) {
      value = formatter.formatEditUpdate(_controller.value, value);
    }

    _controller.value = value.copyWith(
      selection: TextSelection.collapsed(offset: value.text.length),
      composing: TextRange.empty,
    );
  }



  @override
  void dispose() {
    textStream?.close();
    _focusNode.dispose();

    _controller.removeListener(_handleAutoResize);

    if (_isInternalController) {
      _controller.dispose();
    }

    super.dispose();
  }

  TextStyle _baseFontSize() {
    final style = switch (widget.size) {
      AppTextFormFieldSize.small => Theme.of(context).textXSRegular.copyWith(color: Theme.of(context).text.subtle),
      AppTextFormFieldSize.medium => Theme.of(context).textSRegular.copyWith(color: Theme.of(context).text.subtle),
      AppTextFormFieldSize.large => Theme.of(context).textMRegular.copyWith(color: Theme.of(context).text.subtle),
    };
    return (widget.currency != AppTextFormFieldCurrency.rial && widget.type == AppTextFormFieldType.currency) ? style.copyWith(fontFamily: "Roboto") : style;
  }

  void _handleAutoResize() {
    if (!widget.autoFontResize) return;

    final text = _controller.text;
    double base = _baseFontSize().fontSize!;

    // الگوریتم ساده و روان
    double factor = (text.length / 20).clamp(0, 1);
    double newSize = base - (factor * 4);

    if (newSize < minFontSize) {
      newSize = minFontSize;
    }

    if (newSize != dynamicFontStyle.fontSize) {
      setState(() => dynamicFontStyle = dynamicFontStyle.copyWith(fontSize: newSize));
    }
  }

  bool _isFilled() {
    return (_controller.text).isNotEmpty;
  }

  Color _getBorderColor() {
    if (!widget.enabled) return Colors.transparent; // disabled
    if (hasError) return Theme.of(context).border.destructive; // error
    if (isFocused) return Theme.of(context).border.primary; // active
    if (isHovered) return Theme.of(context).border.raised; // hover
    if (_isFilled()) return Theme.of(context).border.subtle; // filled
    return Theme.of(context).border.subtle; // default
  }

  Color _getFillColor() {
    if (!widget.enabled) return Theme.of(context).backgroundSurface.raised.withAlpha(102); // disabled
    if (isFocused) return Theme.of(context).backgroundSurface.main; // active
    if (isHovered) return Theme.of(context).backgroundSurface.main;
    return Theme.of(context).backgroundSurface.main; // default
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            if (widget.label != null)
              InkWell(
                onTap: widget.labelTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(widget.label!, style: Theme.of(context).textSRegular),
                    AppSize.nano.gapWidth,
                    Icon(Icons.info, color: Theme.of(context).icon.soft, size: 12.0),
                    AppSize.nano.gapWidth,
                    if (widget.isRequired ?? false) AppText('*', style: Theme.of(context).textSRegular.copyWith(color: Theme.of(context).text.destructive)),
                  ],
                ),
              ),
            const Spacer(),
            if (widget.maxLength != null && (widget.showCharacterCount ?? false) && widget.type != AppTextFormFieldType.dropdown)
              ValueListenableBuilder(
                valueListenable: _controller,
                builder: (context, TextEditingValue value, _) {
                  final current = value.text.length;
                  final max = widget.maxLength!;

                  Color color;

                  if (current > max) {
                    color = Theme.of(context).text.destructive; // رد شده
                  } else if (current >= (max * 0.8)) {
                    color = Theme.of(context).text.warning; // نزدیک limit
                  } else {
                    color = Theme.of(context).text.subtle;
                  }
                  return AppText('$max / $current', style: Theme.of(context).textXXSRegular.copyWith(color: color));
                },
              ),
          ],
        ),
        AppSize.xxsmall.gapHeight,
        MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  // color: widget.enabled ? null : Colors.transparent.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(() {
                    return switch (widget.size) {
                      AppTextFormFieldSize.small => AppSize.xsmall,
                      AppTextFormFieldSize.medium => AppSize.xsmall,
                      AppTextFormFieldSize.large => AppSize.small,
                    };
                  }()),
                  boxShadow: isFocused ? [BoxShadow(color: Theme.of(context).shadow.active, blurRadius: 0, spreadRadius: 2, offset: Offset.zero)] : [],
                ),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enabled: widget.enabled,
                  readOnly: widget.type == AppTextFormFieldType.dropdown ? true : widget.readOnly,
                  enableSuggestions: widget.enableSuggestions,
                  autocorrect: widget.autocorrect,
                  controller: _controller,
                  focusNode: _focusNode,
                  obscureText: obscureText,
                  cursorColor: Theme.of(context).text.primary,
                  cursorHeight: (widget.autoFontResize ? dynamicFontStyle : _baseFontSize()).fontSize,
                  maxLength: widget.type != AppTextFormFieldType.dropdown ? widget.maxLength : null,
                  buildCounter: widget.type != AppTextFormFieldType.dropdown ? (_, {required currentLength, required isFocused, maxLength}) => null : null,
                  maxLines: widget.type != AppTextFormFieldType.dropdown
                      ? widget.type == AppTextFormFieldType.textMultiline
                            ? null
                            : 1
                      : null,
                  minLines: widget.type != AppTextFormFieldType.dropdown
                      ? widget.type == AppTextFormFieldType.textMultiline
                            ? 4
                            : 1
                      : null,
                  textInputAction: widget.type == AppTextFormFieldType.textMultiline ? TextInputAction.newline : TextInputAction.done,

                  keyboardType: () {
                    return switch (widget.type) {
                      AppTextFormFieldType.text => TextInputType.text,
                      AppTextFormFieldType.dropdown => TextInputType.text,
                      AppTextFormFieldType.password => TextInputType.text,
                      AppTextFormFieldType.email => TextInputType.emailAddress,
                      AppTextFormFieldType.phone => TextInputType.phone,
                      AppTextFormFieldType.address => TextInputType.streetAddress,
                      AppTextFormFieldType.date => TextInputType.datetime,
                      AppTextFormFieldType.currency => const TextInputType.numberWithOptions(decimal: true),
                      AppTextFormFieldType.iban => TextInputType.phone,
                      AppTextFormFieldType.cardNumber => TextInputType.phone,
                      AppTextFormFieldType.textMultiline => TextInputType.multiline,
                    };
                  }(),
                  inputFormatters: [
                    if (widget.type == AppTextFormFieldType.cardNumber) CardNumberInputFormatter(),

                    if (widget.type == AppTextFormFieldType.currency) CurrencyInputFormatter(isRial: widget.currency == AppTextFormFieldCurrency.rial),

                    if (widget.type == AppTextFormFieldType.phone) PhoneInputFormatter(),

                    if (widget.type == AppTextFormFieldType.iban) IBANInputFormatter(),

                    if (widget.type == AppTextFormFieldType.date) DateInputFormatter(),
                  ],
                  // textAlign: widget.type == AppTextFormFieldType.currency ? TextAlign.end : TextAlign.start,
                  textDirection: widget.type == AppTextFormFieldType.currency ? TextDirection.ltr : TextDirection.rtl ,
                  style: widget.autoFontResize ? dynamicFontStyle : _baseFontSize(),
                  onTap: widget.onTap,
                  onSaved: widget.onSaved,
                  onEditingComplete: widget.onEditingComplete,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  decoration: InputDecoration(
                    constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                    prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                    suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                    prefixIcon: widget.type == AppTextFormFieldType.textMultiline
                        ? null
                        : widget.prefixWidget != null
                        ? InkWell(
                            onTap: () {
                              if (widget.type != AppTextFormFieldType.password) {
                                widget.onTapPrefix?.call();
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: (Localizations.localeOf(context) == const Locale('fa')) ? 8.0 : 0.0, left: (Localizations.localeOf(context) == const Locale('fa')) ? 0.0 : 8.0),
                              child: SizedBox.square(
                                dimension: () {
                                  return switch (widget.size) {
                                    AppTextFormFieldSize.small => 16.0,
                                    AppTextFormFieldSize.medium => 20.0,
                                    AppTextFormFieldSize.large => 24.0,
                                  };
                                }(),
                                child: Center(
                                  child: () {
                                    if (widget.type == AppTextFormFieldType.password) {
                                      return HugeIcon(icon: HugeIcons.strokeRoundedSquareLock02,color: (widget.enabled) ? Theme.of(context).icon.subtle : Theme.of(context).icon.subtle.withAlpha(102), );
                                    } else if (widget.type == AppTextFormFieldType.date) {
                                      return HugeIcon(icon: HugeIcons.strokeRoundedCalendar03,color: (widget.enabled) ? Theme.of(context).icon.subtle : Theme.of(context).icon.subtle.withAlpha(102),);
                                    } else {
                                      return widget.prefixWidget;
                                    }
                                  }(),
                                ),
                              ),
                            ),
                          )
                        : (widget.type == AppTextFormFieldType.password) || (widget.type == AppTextFormFieldType.date) ? InkWell(
                      onTap: () {
                        if (widget.type != AppTextFormFieldType.password) {
                          widget.onTapPrefix?.call();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: (Localizations.localeOf(context) == const Locale('fa')) ? 8.0 : 0.0, left: (Localizations.localeOf(context) == const Locale('fa')) ? 0.0 : 8.0),
                        child: SizedBox.square(
                          dimension: () {
                            return switch (widget.size) {
                              AppTextFormFieldSize.small => 16.0,
                              AppTextFormFieldSize.medium => 20.0,
                              AppTextFormFieldSize.large => 24.0,
                            };
                          }(),
                          child: Center(
                            child: () {
                              if (widget.type == AppTextFormFieldType.password) {
                                return HugeIcon(icon: HugeIcons.strokeRoundedSquareLock02,color: (widget.enabled) ? Theme.of(context).icon.subtle : Theme.of(context).icon.subtle.withAlpha(102), );
                              } else if (widget.type == AppTextFormFieldType.date) {
                                return HugeIcon(icon: HugeIcons.strokeRoundedCalendar03,color: (widget.enabled) ? Theme.of(context).icon.subtle : Theme.of(context).icon.subtle.withAlpha(102),);
                              } else {
                                return widget.prefixWidget;
                              }
                            }(),
                          ),
                        ),
                      ),
                    ) : null,
                    suffixIcon: widget.type == AppTextFormFieldType.textMultiline
                        ? null
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if ((widget.type == AppTextFormFieldType.password) || widget.suffixWidget != null)
                                InkWell(
                                  onTap: () {
                                    if (widget.type == AppTextFormFieldType.password) {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    } else {
                                      widget.onTapSuffix?.call();
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: (Localizations.localeOf(context) == const Locale('fa')) ? 8.0 : 0.0,
                                      right: (Localizations.localeOf(context) == const Locale('fa')) ? 0.0 : 8.0,
                                      top: () {
                                        return switch (widget.size) {
                                          AppTextFormFieldSize.small => AppSize.xsmall,
                                          AppTextFormFieldSize.medium => AppSize.xsmall,
                                          AppTextFormFieldSize.large => AppSize.small,
                                        };
                                      }(),
                                      bottom: () {
                                        return switch (widget.size) {
                                          AppTextFormFieldSize.small => AppSize.xsmall,
                                          AppTextFormFieldSize.medium => AppSize.xsmall,
                                          AppTextFormFieldSize.large => AppSize.small,
                                        };
                                      }(),
                                    ),
                                    child: SizedBox.square(
                                      dimension: () {
                                        return switch (widget.size) {
                                          AppTextFormFieldSize.small => 16.0,
                                          AppTextFormFieldSize.medium => 20.0,
                                          AppTextFormFieldSize.large => 24.0,
                                        };
                                      }(),
                                      child: (widget.type == AppTextFormFieldType.password)
                                          ? Center(
                                              child: HugeIcon(
                                                icon: obscureText ? HugeIcons.strokeRoundedView : HugeIcons.strokeRoundedViewOff,
                                                color: widget.enabled ? Theme.of(context).icon.subtle : Theme.of(context).icon.subtle.withAlpha(102),
                                                size: () {
                                                  return switch (widget.size) {
                                                    AppTextFormFieldSize.small => 16.0,
                                                    AppTextFormFieldSize.medium => 20.0,
                                                    AppTextFormFieldSize.large => 24.0,
                                                  };
                                                }(),
                                              ),
                                            )
                                          : Center(child: widget.suffixWidget),
                                    ),
                                  ),
                                ),

                              if (widget.type == AppTextFormFieldType.currency)
                                InkWell(
                                  onTap: widget.onTapSuffixCurrency,
                                  child: Container(
                                    width: () {
                                      return widget.currency == AppTextFormFieldCurrency.rial
                                          ? switch (widget.size) {
                                              AppTextFormFieldSize.small => 55.0,
                                              AppTextFormFieldSize.medium => 63.0,
                                              AppTextFormFieldSize.large => 70.0,
                                            }
                                          : switch (widget.size) {
                                              AppTextFormFieldSize.small => 35.0,
                                              AppTextFormFieldSize.medium => 43.0,
                                              AppTextFormFieldSize.large => 50.0,
                                            };
                                    }(),
                                    height: () {
                                      return switch (widget.size) {
                                        AppTextFormFieldSize.small => 32.0,
                                        AppTextFormFieldSize.medium => 38.0,
                                        AppTextFormFieldSize.large => 48.0,
                                      };
                                    }(),
                                    margin: const EdgeInsets.all(1.0),
                                    decoration: BoxDecoration(
                                      color: (!widget.enabled) ? Colors.transparent : Theme.of(context).backgroundSurface.base,
                                      border: Border(right: BorderSide(color: widget.enabled ? Theme.of(context).border.subtle : Theme.of(context).border.subtle.withAlpha(102))),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(() {
                                          return switch (widget.size) {
                                            AppTextFormFieldSize.small => AppSize.xsmall,
                                            AppTextFormFieldSize.medium => AppSize.xsmall,
                                            AppTextFormFieldSize.large => AppSize.small,
                                          };
                                        }()),
                                        bottomLeft: Radius.circular(() {
                                          return switch (widget.size) {
                                            AppTextFormFieldSize.small => AppSize.xsmall,
                                            AppTextFormFieldSize.medium => AppSize.xsmall,
                                            AppTextFormFieldSize.large => AppSize.small,
                                          };
                                        }()),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AppSize.nano.gapWidth,
                                        Text(
                                          widget.currency!.value ,
                                          style: () {
                                            return switch (widget.size) {
                                              AppTextFormFieldSize.small => Theme.of(context).textXSRegular,
                                              AppTextFormFieldSize.medium => Theme.of(context).textSRegular,
                                              AppTextFormFieldSize.large => Theme.of(context).textMRegular,
                                            };
                                          }().copyWith(color: widget.enabled ? Theme.of(context).text.subtle : Theme.of(context).text.subtle.withAlpha(102)),
                                        ),
                                        AppSize.xxsmall.gapWidth,
                                        HugeIcon(
                                          icon: HugeIcons.strokeRoundedArrowDown01,
                                          size: () {
                                            return switch (widget.size) {
                                              AppTextFormFieldSize.small => 16.0,
                                              AppTextFormFieldSize.medium => 20.0,
                                              AppTextFormFieldSize.large => 24.0,
                                            };
                                          }(),
                                          color: widget.enabled ? Theme.of(context).icon.subtle : Theme.of(context).icon.subtle.withAlpha(102),
                                        ),
                                        AppSize.nano.gapWidth,
                                      ],
                                    ),
                                  ),
                                )
                              else if (widget.type == AppTextFormFieldType.iban)
                                InkWell(
                                  onTap: widget.onTapSuffixIban,
                                  child: Container(
                                    width: () {
                                      return switch (widget.size) {
                                        AppTextFormFieldSize.small => 32.0,
                                        AppTextFormFieldSize.medium => 38.0,
                                        AppTextFormFieldSize.large => 48.0,
                                      };
                                    }(),
                                    height: () {
                                      return switch (widget.size) {
                                        AppTextFormFieldSize.small => 32.0,
                                        AppTextFormFieldSize.medium => 38.0,
                                        AppTextFormFieldSize.large => 48.0,
                                      };
                                    }(),
                                    margin: const EdgeInsets.all(1.0),
                                    decoration: BoxDecoration(
                                      color: (!widget.enabled) ? Colors.transparent : Theme.of(context).backgroundSurface.base,
                                      border: Border(right: BorderSide(color: widget.enabled ? Theme.of(context).border.subtle : Theme.of(context).border.subtle.withAlpha(102))),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(() {
                                          return switch (widget.size) {
                                            AppTextFormFieldSize.small => AppSize.xsmall,
                                            AppTextFormFieldSize.medium => AppSize.xsmall,
                                            AppTextFormFieldSize.large => AppSize.small,
                                          };
                                        }()),
                                        bottomLeft: Radius.circular(() {
                                          return switch (widget.size) {
                                            AppTextFormFieldSize.small => AppSize.xsmall,
                                            AppTextFormFieldSize.medium => AppSize.xsmall,
                                            AppTextFormFieldSize.large => AppSize.small,
                                          };
                                        }()),
                                      ),
                                    ),

                                    child: Center(
                                      child: Text(
                                        'IR',
                                        style: () {
                                          return switch (widget.size) {
                                            AppTextFormFieldSize.small => Theme.of(context).textXSRegular,
                                            AppTextFormFieldSize.medium => Theme.of(context).textSRegular,
                                            AppTextFormFieldSize.large => Theme.of(context).textMRegular,
                                          };
                                        }().copyWith(color: widget.enabled ? Theme.of(context).text.subtle : Theme.of(context).text.subtle.withAlpha(102)),
                                      ),
                                    ),
                                  ),
                                )
                              else if (widget.type == AppTextFormFieldType.dropdown)
                                InkWell(
                                  onTap: widget.onTap,
                                  child: Container(
                                    width: () {
                                      return switch (widget.size) {
                                        AppTextFormFieldSize.small => 32.0,
                                        AppTextFormFieldSize.medium => 38.0,
                                        AppTextFormFieldSize.large => 48.0,
                                      };
                                    }(),
                                    height: () {
                                      return switch (widget.size) {
                                        AppTextFormFieldSize.small => 32.0,
                                        AppTextFormFieldSize.medium => 38.0,
                                        AppTextFormFieldSize.large => 48.0,
                                      };
                                    }(),
                                    margin: const EdgeInsets.all(1.0),
                                    decoration: BoxDecoration(
                                      color: (!widget.enabled) ?Colors.transparent : Theme.of(context).backgroundSurface.base,
                                      border: Border(right: BorderSide(color: widget.enabled ? Theme.of(context).border.subtle : Theme.of(context).border.subtle.withAlpha(102))),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(() {
                                          return switch (widget.size) {
                                            AppTextFormFieldSize.small => AppSize.xsmall,
                                            AppTextFormFieldSize.medium => AppSize.xsmall,
                                            AppTextFormFieldSize.large => AppSize.small,
                                          };
                                        }()),
                                        bottomLeft: Radius.circular(() {
                                          return switch (widget.size) {
                                            AppTextFormFieldSize.small => AppSize.xsmall,
                                            AppTextFormFieldSize.medium => AppSize.xsmall,
                                            AppTextFormFieldSize.large => AppSize.small,
                                          };
                                        }()),
                                      ),
                                    ),
                                    child: Center(
                                      child: HugeIcon(
                                        icon: HugeIcons.strokeRoundedArrowDown01,
                                        size: () {
                                          return switch (widget.size) {
                                            AppTextFormFieldSize.small => 16.0,
                                            AppTextFormFieldSize.medium => 20.0,
                                            AppTextFormFieldSize.large => 24.0,
                                          };
                                        }(),
                                        color: widget.enabled ? Theme.of(context).icon.subtle :Theme.of(context).icon.subtle.withAlpha(102),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                    isDense: true,
                    hintStyle: () {
                      return switch (widget.size) {
                        AppTextFormFieldSize.small => Theme.of(context).textXSRegular.copyWith(color: Theme.of(context).text.soft),
                        AppTextFormFieldSize.medium => Theme.of(context).textSRegular.copyWith(color: Theme.of(context).text.soft),
                        AppTextFormFieldSize.large => Theme.of(context).textMRegular.copyWith(color: Theme.of(context).text.soft),
                      };
                    }(),
                    hoverColor: Colors.transparent,
                    hintText: widget.hint,
                    filled: true,
                    fillColor: _getFillColor(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(() {
                        return switch (widget.size) {
                          AppTextFormFieldSize.small => AppSize.xsmall,
                          AppTextFormFieldSize.medium => AppSize.xsmall,
                          AppTextFormFieldSize.large => AppSize.small,
                        };
                      }()),
                      borderSide: BorderSide(color: _getBorderColor()),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(() {
                        return switch (widget.size) {
                          AppTextFormFieldSize.small => AppSize.xsmall,
                          AppTextFormFieldSize.medium => AppSize.xsmall,
                          AppTextFormFieldSize.large => AppSize.small,
                        };
                      }()),
                      borderSide: BorderSide(color: _getBorderColor()),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(() {
                        return switch (widget.size) {
                          AppTextFormFieldSize.small => AppSize.xsmall,
                          AppTextFormFieldSize.medium => AppSize.xsmall,
                          AppTextFormFieldSize.large => AppSize.small,
                        };
                      }()),
                      borderSide: BorderSide(color: _getBorderColor()),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(() {
                        return switch (widget.size) {
                          AppTextFormFieldSize.small => AppSize.xsmall,
                          AppTextFormFieldSize.medium => AppSize.xsmall,
                          AppTextFormFieldSize.large => AppSize.small,
                        };
                      }()),
                      borderSide: BorderSide(color: _getBorderColor()),
                    ),
                  ),
                  validator: (value) {
                    return null;
                  },
                  onChanged: (value) {
                    widget.onChanged?.call(value);

                    final result = widget.validator?.call(value);
                    setState(() {
                      hasError = result != null;
                      errorMessage = result;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        if (widget.type == AppTextFormFieldType.password)
          StreamBuilder(
            stream: textStream?.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PasswordHelper(passwordValue: snapshot.data ?? '');
              }
              return const PasswordHelper(passwordValue: '');
            },
          )
        else ...[
          if (hasError) ...[AppSize.xxsmall.gapHeight, AppText(errorMessage ?? '', style: Theme.of(context).textXSRegular.copyWith(color: Theme.of(context).text.destructive))],
          // else
          if (widget.helperText != null && widget.helperText!.isNotEmpty) ...[AppSize.xxsmall.gapHeight, AppText(widget.helperText!, style: Theme.of(context).textXSRegular.copyWith(color: Theme.of(context).text.sub))],
        ],
      ],
    );
  }
}
