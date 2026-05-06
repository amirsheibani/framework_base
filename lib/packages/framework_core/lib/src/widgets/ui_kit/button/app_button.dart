import 'package:flutter/material.dart';
import 'package:framework_base/framework_base.dart';

import '../gap/app_size.dart';

enum AppButtonSize { small, medium, large }

enum AppButtonType { primaryFilled, primaryOutline, primaryGhost, neutralFilled, neutralOutline, neutralGhost, destructiveFilled, destructiveOutline, destructiveGhost }

class AppButton extends StatelessWidget {
  final AppButtonType type;
  final AppButtonSize size;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? text;
  final bool isIconOnly;

  const AppButton({super.key, required this.type, this.size = AppButtonSize.large, this.onPressed, this.onLongPress, this.suffixIcon, this.prefixIcon, this.text})
    : isIconOnly = false,
      assert(!(text == null && (prefixIcon != null || suffixIcon != null)), 'Text cannot be null when prefixIcon or suffixIcon is provided.');

  const AppButton.icon({super.key, required this.type, this.size = AppButtonSize.large, this.onPressed, this.onLongPress, required Widget icon}) : isIconOnly = true, prefixIcon = icon, text = null, suffixIcon = null;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: true, focusColor: Colors.transparent, hoverColor: Colors.transparent, highlightColor: Colors.transparent, splashColor: Colors.transparent),
      child: ElevatedButton(
        style: () {
          return switch (type) {
            AppButtonType.primaryFilled => ButtonStyle(
              elevation: WidgetStateProperty.all(0),
              surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
              shadowColor: WidgetStateProperty.all(Colors.transparent),
              overlayColor: WidgetStateProperty.resolveWith((states) => Colors.transparent),
              textStyle: WidgetStateProperty.resolveWith((states) {
                final textStyle = () {
                  return switch (size) {
                    AppButtonSize.small => Theme.of(context).textXSRegular.copyWith(color: Theme.of(context).text.foreground),
                    AppButtonSize.medium => Theme.of(context).textSRegular.copyWith(color: Theme.of(context).text.foreground),
                    AppButtonSize.large => Theme.of(context).textMRegular.copyWith(color: Theme.of(context).text.foreground),
                  };
                }();
                return textStyle;
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                return Theme.of(context).text.foreground;
              }),
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                final base = Theme.of(context).backgroundSurface.primary;
                if (states.contains(WidgetState.disabled)) {
                  return base.withAlpha(102);
                }
                if (states.contains(WidgetState.pressed)) {
                  return Color.alphaBlend(Theme.of(context).press, base);
                }
                if (states.contains(WidgetState.hovered)) {
                  return Color.alphaBlend(Theme.of(context).hover, base);
                }
                return base; // Default
              }),

              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.small))),
            ),

            AppButtonType.primaryOutline => ButtonStyle(
              elevation: WidgetStateProperty.all(0),
              surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
              shadowColor: WidgetStateProperty.all(Colors.transparent),
              overlayColor: WidgetStateProperty.resolveWith((states) => Colors.transparent),
              textStyle: WidgetStateProperty.resolveWith((states) {
                final textStyle = () {
                  return switch (size) {
                    AppButtonSize.small => Theme.of(context).textXSRegular.copyWith(color: Theme.of(context).text.foreground),
                    AppButtonSize.medium => Theme.of(context).textSRegular.copyWith(color: Theme.of(context).text.foreground),
                    AppButtonSize.large => Theme.of(context).textMRegular.copyWith(color: Theme.of(context).text.foreground),
                  };
                }();
                return textStyle;
              }),
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return Theme.of(context).backgroundSurface.main;
                }
                if (states.contains(WidgetState.pressed)) {
                  return Theme.of(context).backgroundSurface.primaryMedium;
                }
                if (states.contains(WidgetState.hovered)) {
                  return Theme.of(context).backgroundSurface.primaryLow;
                }
                if (states.contains(WidgetState.focused)) {
                  return Theme.of(context).backgroundSurface.primaryLow;
                }
                return Theme.of(context).backgroundSurface.main; // Default
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                final disabled = states.contains(WidgetState.disabled);
                if (!disabled) return Theme.of(context).text.primary;
                return Theme.of(context).text.primary.withAlpha(102);
              }),
              side: WidgetStateProperty.resolveWith((states) {
                final border = Theme.of(context).border.primary;
                if (states.contains(WidgetState.disabled)) {
                  return BorderSide(color: border.withAlpha(102), width: 1);
                }
                return BorderSide(color: border, width: 1);
              }),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.small))),
            ),
            AppButtonType.primaryGhost => ButtonStyle(
              elevation: WidgetStateProperty.all(0),
              surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
              shadowColor: WidgetStateProperty.all(Colors.transparent),
              overlayColor: WidgetStateProperty.resolveWith((states) => Colors.transparent),
              textStyle: WidgetStateProperty.resolveWith((states) {
                final textStyle = () {
                  return switch (size) {
                    AppButtonSize.small => Theme.of(context).textXSRegular.copyWith(color: Theme.of(context).text.foreground),
                    AppButtonSize.medium => Theme.of(context).textSRegular.copyWith(color: Theme.of(context).text.foreground),
                    AppButtonSize.large => Theme.of(context).textMRegular.copyWith(color: Theme.of(context).text.foreground),
                  };
                }();
                return textStyle;
              }),
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return Theme.of(context).backgroundSurface.main;
                }
                if (states.contains(WidgetState.pressed)) {
                  return Theme.of(context).backgroundSurface.primaryMedium;
                }
                if (states.contains(WidgetState.hovered)) {
                  return Theme.of(context).backgroundSurface.primaryLow;
                }
                return Theme.of(context).backgroundSurface.main; // Default
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                final disabled = states.contains(WidgetState.disabled);
                if (!disabled) return Theme.of(context).text.primary;
                return Theme.of(context).text.primary.withAlpha(102);
              }),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.small))),
            ),

            AppButtonType.neutralFilled => ButtonStyle(
              elevation: WidgetStateProperty.all(0),
              surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
              shadowColor: WidgetStateProperty.all(Colors.transparent),
              overlayColor: WidgetStateProperty.resolveWith((states) => Colors.transparent),
              textStyle: WidgetStateProperty.resolveWith((states) {
                final textStyle = () {
                  return switch (size) {
                    AppButtonSize.small => Theme.of(context).textXSRegular.copyWith(color: Theme.of(context).text.foreground),
                    AppButtonSize.medium => Theme.of(context).textSRegular.copyWith(color: Theme.of(context).text.foreground),
                    AppButtonSize.large => Theme.of(context).textMRegular.copyWith(color: Theme.of(context).text.foreground),
                  };
                }();

                return textStyle;
              }),
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                final base = Theme.of(context).backgroundSurface.raised;
                if (states.contains(WidgetState.disabled)) {
                  return base.withAlpha(102);
                }
                if (states.contains(WidgetState.pressed)) {
                  return Color.alphaBlend(Theme.of(context).press, base);
                }
                if (states.contains(WidgetState.hovered)) {
                  return Color.alphaBlend(Theme.of(context).hover, base);
                }
                return base; // Default
              }),
              // Text / Icon color
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                final disabled = states.contains(WidgetState.disabled);
                if (!disabled) return Theme.of(context).text.secondaryForeground;
                ;
                return Theme.of(context).text.secondaryForeground.withAlpha(102);
              }),
              // Shape
              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.small))),
            ),
            AppButtonType.neutralOutline => ButtonStyle(
              elevation: WidgetStateProperty.all(0),
              surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
              shadowColor: WidgetStateProperty.all(Colors.transparent),
              overlayColor: WidgetStateProperty.resolveWith((states) => Colors.transparent),
              textStyle: WidgetStateProperty.resolveWith((states) {
                final textStyle = () {
                  return switch (size) {
                    AppButtonSize.small => Theme.of(context).textXSRegular.copyWith(color: Theme.of(context).text.foreground),
                    AppButtonSize.medium => Theme.of(context).textSRegular.copyWith(color: Theme.of(context).text.foreground),
                    AppButtonSize.large => Theme.of(context).textMRegular.copyWith(color: Theme.of(context).text.foreground),
                  };
                }();
                return textStyle;
              }),
              // Background
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return Theme.of(context).backgroundSurface.main;
                }
                if (states.contains(WidgetState.pressed)) {
                  return Theme.of(context).backgroundSurface.subtle;
                }
                if (states.contains(WidgetState.hovered)) {
                  return Theme.of(context).backgroundSurface.base;
                }
                if (states.contains(WidgetState.focused)) {
                  return Theme.of(context).backgroundSurface.base;
                }
                return Theme.of(context).backgroundSurface.main; // Default
              }),

              // Text / Icon color
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                final disabled = states.contains(WidgetState.disabled);
                if (!disabled) return Theme.of(context).text.subtle;
                return Theme.of(context).text.subtle.withAlpha(102);
              }),
              // Border
              side: WidgetStateProperty.resolveWith((states) {
                final border = Theme.of(context).border.base;

                if (states.contains(WidgetState.disabled)) {
                  return BorderSide(color: border.withAlpha(102), width: 1);
                }
                return BorderSide(color: border, width: 1);
              }),
              // Shape
              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.small))),
            ),
            AppButtonType.neutralGhost => ButtonStyle(
              elevation: WidgetStateProperty.all(0),
              surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
              shadowColor: WidgetStateProperty.all(Colors.transparent),
              overlayColor: WidgetStateProperty.resolveWith((states) => Colors.transparent),
              textStyle: WidgetStateProperty.resolveWith((states) {
                final textStyle = () {
                  return switch (size) {
                    AppButtonSize.small => Theme.of(context).textXSRegular.copyWith(color: Theme.of(context).text.foreground),
                    AppButtonSize.medium => Theme.of(context).textSRegular.copyWith(color: Theme.of(context).text.foreground),
                    AppButtonSize.large => Theme.of(context).textMRegular.copyWith(color: Theme.of(context).text.foreground),
                  };
                }();
                return textStyle;
              }),
              // Background
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return Theme.of(context).backgroundSurface.main;
                }
                if (states.contains(WidgetState.pressed)) {
                  return Theme.of(context).backgroundSurface.subtle;
                }
                if (states.contains(WidgetState.hovered)) {
                  return Theme.of(context).backgroundSurface.base;
                }
                return Theme.of(context).backgroundSurface.main; // Default
              }),

              foregroundColor: WidgetStateProperty.resolveWith((states) {
                final disabled = states.contains(WidgetState.disabled);
                if (!disabled) return Theme.of(context).text.subtle;
                return Theme.of(context).text.subtle.withAlpha(102);
              }),

              // Shape
              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.small))),

              side: WidgetStateProperty.resolveWith((states) {
                final focused = states.contains(WidgetState.focused);
                if (!focused) return BorderSide.none;

                return BorderSide(color: Theme.of(context).backgroundFunc.destructiveLow, width: 4, strokeAlign: BorderSide.strokeAlignOutside);
              }),
            ),

            AppButtonType.destructiveFilled => ButtonStyle(
              elevation: WidgetStateProperty.all(0),
              surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
              shadowColor: WidgetStateProperty.all(Colors.transparent),
              overlayColor: WidgetStateProperty.resolveWith((states) => Colors.transparent),
              textStyle: WidgetStateProperty.resolveWith((states) {
                final textStyle = () {
                  return switch (size) {
                    AppButtonSize.small => Theme.of(context).textXSRegular.copyWith(color: Theme.of(context).text.foreground),
                    AppButtonSize.medium => Theme.of(context).textSRegular.copyWith(color: Theme.of(context).text.foreground),
                    AppButtonSize.large => Theme.of(context).textMRegular.copyWith(color: Theme.of(context).text.foreground),
                  };
                }();
                return textStyle;
              }),
              // Background
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                final base = Theme.of(context).backgroundFunc.destructive;
                if (states.contains(WidgetState.disabled)) {
                  return base.withAlpha(102);
                }
                if (states.contains(WidgetState.pressed)) {
                  return Color.alphaBlend(Theme.of(context).press, base);
                }
                if (states.contains(WidgetState.hovered)) {
                  return Color.alphaBlend(Theme.of(context).hover, base);
                }
                return base; // Default
              }),
              // Text / Icon color
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                return Theme.of(context).text.foreground;
              }),
              // Shape
              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.small))),
            ),
            AppButtonType.destructiveOutline => ButtonStyle(
              surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
              shadowColor: WidgetStateProperty.all(Colors.transparent),
              overlayColor: WidgetStateProperty.resolveWith((states) => Colors.transparent),
              textStyle: WidgetStateProperty.resolveWith((states) {
                final textStyle = () {
                  return switch (size) {
                    AppButtonSize.small => Theme.of(context).textXSRegular.copyWith(color: Theme.of(context).text.foreground),
                    AppButtonSize.medium => Theme.of(context).textSRegular.copyWith(color: Theme.of(context).text.foreground),
                    AppButtonSize.large => Theme.of(context).textMRegular.copyWith(color: Theme.of(context).text.foreground),
                  };
                }();
                return textStyle;
              }),
              // Background
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return Theme.of(context).backgroundSurface.main;
                }
                if (states.contains(WidgetState.pressed)) {
                  return Theme.of(context).backgroundFunc.destructiveMedium;
                }
                if (states.contains(WidgetState.hovered)) {
                  return Theme.of(context).backgroundFunc.destructiveLow;
                }
                if (states.contains(WidgetState.focused)) {
                  return Theme.of(context).backgroundFunc.destructiveLow;
                }
                return Theme.of(context).backgroundSurface.main; // Default
              }),
              // Text / Icon color
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                final disabled = states.contains(WidgetState.disabled);
                if (!disabled) return Theme.of(context).text.destructive;
                return Theme.of(context).text.destructive.withAlpha(102);
              }),
              // Border
              side: WidgetStateProperty.resolveWith((states) {
                final border = Theme.of(context).border.destructive;

                if (states.contains(WidgetState.disabled)) {
                  return BorderSide(color: border.withAlpha(102), width: 1);
                }
                return BorderSide(color: border, width: 1);
              }),
              // Shape
              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.small))),
            ),
            AppButtonType.destructiveGhost => ButtonStyle(
              elevation: WidgetStateProperty.all(0),
              surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
              shadowColor: WidgetStateProperty.all(Colors.transparent),
              overlayColor: WidgetStateProperty.resolveWith((states) => Colors.transparent),
              textStyle: WidgetStateProperty.resolveWith((states) {
                final textStyle = () {
                  return switch (size) {
                    AppButtonSize.small => Theme.of(context).textXSRegular.copyWith(color: Theme.of(context).text.foreground),
                    AppButtonSize.medium => Theme.of(context).textSRegular.copyWith(color: Theme.of(context).text.foreground),
                    AppButtonSize.large => Theme.of(context).textMRegular.copyWith(color: Theme.of(context).text.foreground),
                  };
                }();
                return textStyle;
              }),
              // Background
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return Theme.of(context).backgroundSurface.main;
                }
                if (states.contains(WidgetState.pressed)) {
                  return Theme.of(context).backgroundFunc.destructiveMedium;
                }
                if (states.contains(WidgetState.hovered)) {
                  return Theme.of(context).backgroundFunc.destructiveLow;
                }
                if (states.contains(WidgetState.focused)) {
                  return Theme.of(context).backgroundFunc.destructiveLow;
                }
                return Theme.of(context).backgroundSurface.main; // Default
              }),
              // Text / Icon color
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                final disabled = states.contains(WidgetState.disabled);
                if (!disabled) return Theme.of(context).text.destructive;
                return Theme.of(context).text.destructive.withAlpha(102);
              }),

              // Shape
              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.small))),

              side: WidgetStateProperty.resolveWith((states) {
                final focused = states.contains(WidgetState.focused);
                if (!focused) return BorderSide.none;

                return BorderSide(color: Theme.of(context).backgroundFunc.destructiveLow, width: 4, strokeAlign: BorderSide.strokeAlignOutside);
              }),
            ),
          };
        }(),
        onPressed: onPressed,
        onLongPress: onLongPress,
        child: _BodyWidget(suffixIcon: suffixIcon, prefixIcon: prefixIcon, text: text, size: size, isIconOnly: isIconOnly),
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? text;
  final AppButtonSize size;
  final bool isIconOnly;

  const _BodyWidget({this.suffixIcon, this.prefixIcon, this.text, required this.size, required this.isIconOnly});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.medium,
        vertical: () {
          return switch (size) {
            AppButtonSize.small => 8.0,
            AppButtonSize.medium => 10.0,
            AppButtonSize.large => 12.0,
          };
        }(),
      ),
      child: isIconOnly
          ? SizedBox.square(
              dimension: () {
                return switch (size) {
                  AppButtonSize.small => 16.0,
                  AppButtonSize.medium => 20.0,
                  AppButtonSize.large => 24.0,
                };
              }(),
              child: Center(child: prefixIcon),
            )
          : SizedBox(
              height: () {
                return switch (size) {
                  AppButtonSize.small => 16.0,
                  AppButtonSize.medium => 20.0,
                  AppButtonSize.large => 24.0,
                };
              }(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prefixIcon != null) ...[prefixIcon!, AppSize.xsmall.gapWidth],
                  if (text != null) text!,
                  if (suffixIcon != null) ...[AppSize.xsmall.gapWidth, suffixIcon!],
                ],
              ),
            ),
    );
  }
}
