import 'package:flutter/material.dart';
import 'package:framework_base/framework_base.dart';

class AppRadioTile extends StatefulWidget {
  const AppRadioTile({super.key, this.onChanged, this.initValue = false, required this.title, this.description, this.trailing,  this.size = AppRadioSize.small});

  final ValueChanged<bool>? onChanged;
  final bool initValue;
  final String title;
  final String? description;
  final Widget? trailing;
  final AppRadioSize size;

  @override
  State<AppRadioTile> createState() => _AppRadioTileState();
}

class _AppRadioTileState extends State<AppRadioTile> {
  bool selected = false;
  bool isHovered = false;
  bool isFocused = false;


  @override
  void didUpdateWidget(covariant AppRadioTile oldWidget) {
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
          setState(() => selected = !selected);
          widget.onChanged?.call(selected);
        },
        child: Container(
          decoration: BoxDecoration(
            color: isHovered ? Theme.of(context).backgroundSurface.main : Theme.of(context).backgroundSurface.main,
            borderRadius: BorderRadius.circular(AppSize.small),
            border: Border.all(
              color: selected
                  ? Theme.of(context).border.primary
                  : isHovered
                  ? Theme.of(context).border.raised
                  : Theme.of(context).border.subtle,
              width: selected ? 2 : 1,
            ),
            boxShadow: selected ? [BoxShadow(color: Theme.of(context).shadow.active, blurRadius: 0, spreadRadius: 2, offset: Offset.zero)] : [],
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
                    AppText(widget.title, style: Theme.of(context).textSRegular.copyWith(color: Theme.of(context).text.main)),
                    if (widget.description != null) ...[
                      AppSize.xxsmall.gapHeight,
                      Flexible(
                        child: AppText(widget.description!, style: Theme.of(context).textSRegular.copyWith(color: Theme.of(context).text.soft)),
                      ),
                    ],
                  ],
                ),
              ),
              AppRadio(
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
