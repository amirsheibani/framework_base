import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:framework_base/framework_base.dart';
enum AppRadioState {
  normal,
  hover,
  pressed,
  focused,
  disabled,
}

enum AppRadioSize {
  small,
  large,
}

class AppRadio extends StatefulWidget {
  final bool selected;
  final bool disabled;
  final AppRadioSize size;
  final ValueChanged<bool>? onChanged;
  const AppRadio({super.key,required this.selected,
    this.disabled = false,
    this.size = AppRadioSize.small,
    this.onChanged,});

  @override
  State<AppRadio> createState() => _AppRadioState();
}

class _AppRadioState extends State<AppRadio> {
  late AppRadioState state;

  void _setState(AppRadioState newState) {
    if (widget.disabled) return;
    setState(() => state = newState);
  }

  @override
  void initState() {
    state = widget.disabled ? AppRadioState.disabled : AppRadioState.normal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double size =
    widget.size == AppRadioSize.small ? 16 : 20;



    return MouseRegion(
      onEnter: (_) => _setState(AppRadioState.hover),
      onExit: (_) => _setState(AppRadioState.normal),
      child: GestureDetector(
        onTapDown: (_) => _setState(AppRadioState.pressed),
        onTapUp: (_) {
          _setState(AppRadioState.hover);
          if (!widget.disabled) widget.onChanged?.call(!widget.selected);
        },
        onTapCancel: () => _setState(AppRadioState.normal),
        child: FocusableActionDetector(
          onShowFocusHighlight: (focused) =>
              _setState(focused ? AppRadioState.focused : AppRadioState.normal),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: size,
            height: size,
            decoration: _buildDecoration(),
          ),
        ),
      ),
    );
  }

  Decoration _buildDecoration() {
    final bool selected = widget.selected;

    Color border;
    Color fill;

    switch (state) {
      case AppRadioState.normal:
        border = selected ? Theme.of(context).border.primary :Theme.of(context).border.subtle ;
        fill = selected ? Theme.of(context).backgroundSurface.main : Theme.of(context).backgroundSurface.main;
        break;

      case AppRadioState.hover:
        border = selected ? Theme.of(context).border.primary : Theme.of(context).border.primarySubtle;
        fill = selected ? Theme.of(context).backgroundSurface.primaryLow : Theme.of(context).backgroundSurface.primaryLow;
        break;

      case AppRadioState.pressed:
        border = selected ? Theme.of(context).border.primary : Theme.of(context).border.primarySubtle;
        fill = selected ? Theme.of(context).backgroundSurface.primaryMedium: Theme.of(context).backgroundSurface.primaryMedium;
        break;

      case AppRadioState.focused:
        border = selected ? Theme.of(context).border.primary : Theme.of(context).border.primarySubtle;
        fill = selected ? Theme.of(context).backgroundSurface.main : Theme.of(context).backgroundSurface.main;
        break;

      case AppRadioState.disabled:
        border = selected ? Theme.of(context).border.primary.withAlpha(102) : Theme.of(context).border.primarySubtle.withAlpha(102);
        fill = selected ? Theme.of(context).backgroundSurface.main : Theme.of(context).backgroundSurface.main;
        break;
    }

    return BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: border,
        width: selected ? (widget.size == AppRadioSize.large) ? 5 : 4 : 1,
      ),
      color: fill,
    );
  }
}
