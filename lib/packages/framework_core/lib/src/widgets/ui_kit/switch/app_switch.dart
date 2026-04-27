import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:framework_base/framework_base.dart';

enum AppSwitchSize {
  small,
  large,
}

enum AppSwitchState {
  normal,
  hover,
  pressed,
  focused,
  disabled,
}

class AppSwitch extends StatefulWidget {
  final bool selected;
  final ValueChanged<bool>? onChanged;
  final bool disabled;
  final AppSwitchSize size;

  const AppSwitch({
    super.key,
    required this.selected,
    this.onChanged,
    this.disabled = false,
    this.size = AppSwitchSize.small,
  });

  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch>
    with SingleTickerProviderStateMixin {
  double dragPos = 0.0;
  bool isDragging = false;
  AppSwitchState currentState = AppSwitchState.normal;

  @override
  void initState() {
    dragPos = widget.selected ? 1.0 : 0.0;
    if (widget.disabled) currentState = AppSwitchState.disabled;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppSwitch old) {
    if (!isDragging) dragPos = widget.selected ? 1.0 : 0.0;

    if (widget.disabled) {
      currentState = AppSwitchState.disabled;
    } else if (currentState == AppSwitchState.disabled) {
      currentState = AppSwitchState.normal;
    }

    super.didUpdateWidget(old);
  }

  // تغییر حالت‌ها
  void _set(AppSwitchState s) {
    if (widget.disabled) return;
    setState(() => currentState = s);
  }

  void _animateTo(bool newValue) {
    HapticFeedback.selectionClick();
    widget.onChanged?.call(newValue);

    setState(() {
      dragPos = newValue ? 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {

    final bool isOn = widget.selected;
    final bool disabled = widget.disabled || widget.onChanged == null;

    // sizes
    final double w = widget.size == AppSwitchSize.small ? 36 : 42;
    final double h = widget.size == AppSwitchSize.small ? 16 : 20;
    final double thumb = h - 2;

    // رنگ‌ها بر اساس state machine
    Color trackColor;
    Color thumbColor;

    switch (currentState) {
      case AppSwitchState.disabled:
        trackColor = disabled
            ? (!isOn ? Theme.of(context).backgroundSurface.emphasis.withAlpha(102): Theme.of(context).backgroundSurface.primary ).withAlpha(102)
            : (!isOn ? Theme.of(context).backgroundSurface.emphasis: Theme.of(context).backgroundSurface.primary );
        thumbColor = Theme.of(context).backgroundSurface.main;
        break;
      case AppSwitchState.focused:
      case AppSwitchState.pressed:
      case AppSwitchState.hover:
      case AppSwitchState.normal:
        trackColor = disabled
            ? (!isOn ? Theme.of(context).backgroundSurface.emphasis.withAlpha(102): Theme.of(context).backgroundSurface.primary ).withAlpha(102)
            : (!isOn ? Theme.of(context).backgroundSurface.emphasis: Theme.of(context).backgroundSurface.primary );
        thumbColor = Theme.of(context).backgroundSurface.main;
        break;

      // case AppSwitchState.hover:
      //   trackColor = isOn ? bg.primaryMedium : border.primarySubtle;
      //   thumbColor = bg.main;
      //   break;
      //
      // case AppSwitchState.pressed:
      //   trackColor = isOn
      //       ? bg.primaryMedium.withOpacity(0.9)
      //       : border.primary.withOpacity(0.6);
      //   thumbColor = bg.main;
      //   break;
      //
      // case AppSwitchState.focused:
      //   trackColor = isOn ? bg.primaryMedium : border.primarySubtle;
      //   thumbColor = bg.main;
      //   break;
      //
      // case AppSwitchState.disabled:
      //   trackColor = border.primarySubtle.withOpacity(0.3);
      //   thumbColor = bg.main.withOpacity(0.6);
      //   break;
    }

    return FocusableActionDetector(
      onShowFocusHighlight: (focused) =>
          _set(focused ? AppSwitchState.focused : AppSwitchState.normal),
      child: MouseRegion(
        onEnter: (_) => _set(AppSwitchState.hover),
        onExit: (_) => _set(AppSwitchState.normal),
        child: GestureDetector(
          onTapDown: disabled ? null : (_) => _set(AppSwitchState.pressed),
          onTapCancel: disabled ? null : () => _set(AppSwitchState.normal),
          onTapUp: disabled
              ? null
              : (_) {
            _set(AppSwitchState.hover);
            _animateTo(!isOn);
          },

          // Drag iOS-like
          onHorizontalDragStart: disabled
              ? null
              : (_) {
            isDragging = true;
            _set(AppSwitchState.pressed);
            HapticFeedback.selectionClick();
          },

          onHorizontalDragUpdate: disabled
              ? null
              : (details) {
            setState(() {
              dragPos += details.primaryDelta! / (w - thumb - 6);
              dragPos = dragPos.clamp(0, 1);
            });
          },

          onHorizontalDragEnd: disabled
              ? null
              : (_) {
            isDragging = false;
            _set(AppSwitchState.hover);

            final shouldOn = dragPos > 0.5;
            _animateTo(shouldOn);
          },

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 170),
            curve: Curves.easeOut,
            width: w,
            height: h,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(h),
              color: trackColor,
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  duration: isDragging
                      ? Duration.zero
                      : const Duration(milliseconds: 180),
                  alignment: Alignment(-0.9 + dragPos * 1.8, 0),
                  curve: Curves.easeOut,
                  child: Container(
                    width: thumb * 1.45,
                    height: thumb,
                    decoration: BoxDecoration(
                      color: thumbColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(thumb),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
