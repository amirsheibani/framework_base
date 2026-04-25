import 'dart:async';

import 'package:flutter/material.dart';
import 'package:framework_base/framework_base.dart';
import 'package:hugeicons/hugeicons.dart';




enum AppDropdownSize { small, medium, large }

class AppDropdown extends StatefulWidget {
  const AppDropdown({
    super.key,
    this.size = AppDropdownSize.large,
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
  });

  final AppDropdownSize size;
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

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
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
      _controller = TextEditingController();
      _isInternalController = true;
    }

    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
    _controller.addListener(_handleAutoResize);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    dynamicFontStyle = _baseFontSize();
  }

  @override
  void dispose() {
    _focusNode.dispose();

    _controller.removeListener(_handleAutoResize);

    if (_isInternalController) {
      _controller.dispose();
    }

    super.dispose();
  }

  TextStyle _baseFontSize() {
    final style = switch (widget.size) {
      AppDropdownSize.small => Theme.of(context).textXSRegular.copyWith(color: Theme.of(context).text.subtle),
      AppDropdownSize.medium => Theme.of(context).textSRegular.copyWith(color: Theme.of(context).text.subtle),
      AppDropdownSize.large => Theme.of(context).textMRegular.copyWith(color: Theme.of(context).text.subtle),
    };
    return style;
  }

  void _handleAutoResize() {
    if (!widget.autoFontResize) return;

    final text = _controller.text;
    double base = _baseFontSize().fontSize!;

    double newSize = base - (text.length * 0.3);

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
          ],
        ),
        AppSize.xxsmall.gapHeight,
        MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(() {
                return switch (widget.size) {
                  AppDropdownSize.small => AppSize.xsmall,
                  AppDropdownSize.medium => AppSize.xsmall,
                  AppDropdownSize.large => AppSize.small,
                };
              }()),
              boxShadow: isFocused ? [BoxShadow(color: Theme.of(context).shadow.active, blurRadius: 0, spreadRadius: 2, offset: Offset.zero)] : [],
            ),
            child: InkWell(
              onTap: widget.onTap,
              child: Row(
                children: [
                  Expanded(child: AppText(widget.controller?.text ?? '', style: dynamicFontStyle)),
                  Container(
                    width: () {
                      return switch (widget.size) {
                        AppDropdownSize.small => 32.0,
                        AppDropdownSize.medium => 38.0,
                        AppDropdownSize.large => 48.0,
                      };
                    }(),
                    height: () {
                      return switch (widget.size) {
                        AppDropdownSize.small => 32.0,
                        AppDropdownSize.medium => 38.0,
                        AppDropdownSize.large => 48.0,
                      };
                    }(),
                    margin: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      color: _getFillColor(),
                      border: Border(right: BorderSide(color: _getBorderColor())),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(() {
                          return switch (widget.size) {
                            AppDropdownSize.small => AppSize.xsmall,
                            AppDropdownSize.medium => AppSize.xsmall,
                            AppDropdownSize.large => AppSize.small,
                          };
                        }()),
                        bottomLeft: Radius.circular(() {
                          return switch (widget.size) {
                            AppDropdownSize.small => AppSize.xsmall,
                            AppDropdownSize.medium => AppSize.xsmall,
                            AppDropdownSize.large => AppSize.small,
                          };
                        }()),
                      ),
                    ),
                    child: Center(
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowDown01,
                        size: () {
                          return switch (widget.size) {
                            AppDropdownSize.small => 16.0,
                            AppDropdownSize.medium => 20.0,
                            AppDropdownSize.large => 24.0,
                          };
                        }(),
                        color: Theme.of(context).icon.subtle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ...[
          if (hasError) ...[AppSize.xxsmall.gapHeight, AppText(errorMessage ?? '', style: Theme.of(context).textXSRegular.copyWith(color: Theme.of(context).text.destructive))],
          // else
          if (widget.helperText != null && widget.helperText!.isNotEmpty) ...[AppSize.xxsmall.gapHeight, AppText(widget.helperText!, style: Theme.of(context).textXSRegular.copyWith(color: Theme.of(context).text.sub))],
        ],
      ],
    );
  }
}
