import 'package:flutter/material.dart';
import 'package:framework_base/framework_base.dart';

class AppSwitchTile extends StatefulWidget {
  const AppSwitchTile({super.key, this.onChanged, this.initValue = false, required this.title, this.description, this.trailing,  this.size = AppSwitchSize.small, this.disabled = false});

  final ValueChanged<bool>? onChanged;
  final bool initValue;
  final String title;
  final String? description;
  final Widget? trailing;
  final AppSwitchSize size;
  final bool disabled;

  @override
  State<AppSwitchTile> createState() => _AppSwitchTileState();
}

class _AppSwitchTileState extends State<AppSwitchTile> {
  bool selected = false;
  bool isHovered = false;
  bool isFocused = false;


  @override
  void didUpdateWidget(covariant AppSwitchTile oldWidget) {
    selected = widget.initValue;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () {
          if(!widget.disabled){
            setState(() => selected = !selected);
            widget.onChanged?.call(selected);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: widget.disabled ? Theme.of(context).backgroundSurface.main.withAlpha(102) :Theme.of(context).backgroundSurface.main,
            borderRadius: BorderRadius.circular(AppSize.small),
            border: Border.all(
              color: selected
                  ? widget.disabled ? Theme.of(context).border.primary.withAlpha(102) : Theme.of(context).border.primary
                  : isHovered
                  ? widget.disabled ? Theme.of(context).border.raised.withAlpha(102) :Theme.of(context).border.raised
                  : widget.disabled ? Theme.of(context).border.subtle.withAlpha(102) :Theme.of(context).border.subtle,
              width: selected ? 2 : 1,
            ),
            boxShadow: widget.disabled  ?[] : selected ? [BoxShadow(color: Theme.of(context).shadow.active, blurRadius: 0, spreadRadius: 2, offset: Offset.zero)] : [],
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSize.base, vertical: AppSize.base),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.trailing != null) ...[widget.trailing!, AppSize.small.gapWidth],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(widget.title, style: Theme.of(context).textSRegular.copyWith(color: widget.disabled ?Theme.of(context).text.main.withAlpha(102) :Theme.of(context).text.main)),
                    if (widget.description != null) ...[
                      AppSize.xxsmall.gapHeight,
                      Flexible(
                        child: AppText(widget.description!, style: Theme.of(context).textSRegular.copyWith(color:widget.disabled ? Theme.of(context).text.soft.withAlpha(102): Theme.of(context).text.soft)),
                      ),
                    ],
                  ],
                ),
              ),
              AppSwitch(
                disabled: widget.disabled,
                size: widget.size,
                selected: selected,
                onChanged: (value) {
                  setState(() {
                    selected = value;
                  });
                  widget.onChanged?.call(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
