import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:framework_base/framework_base.dart';

class AppSwitchLabel extends StatefulWidget {
  const AppSwitchLabel({super.key, this.onChanged, this.initValue = false, required this.label, this.onTapLabel, this.onTap, this.description, this.size = AppSwitchSize.small, this.disabled = false});
  final ValueChanged<bool>? onChanged;
  final bool initValue;
  final String label;
  final String? description;
  final String? onTapLabel;
  final VoidCallback? onTap;
  final AppSwitchSize size;
  final bool disabled;

  @override
  State<AppSwitchLabel> createState() => _AppSwitchLabelState();
}

class _AppSwitchLabelState extends State<AppSwitchLabel> {
  bool selected = false;


@override
  void didUpdateWidget(covariant AppSwitchLabel oldWidget) {
    selected = widget.initValue;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSwitch(
          disabled: widget.disabled,
          size: widget.size,
          selected: selected,onChanged: (value){
          setState(() {
            selected = value;
          });
          widget.onChanged?.call(value);
        },),
        AppSize.xxsmall.gapWidth,
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(widget.label, style: Theme.of(context).textSRegular.copyWith(color: widget.disabled ? Theme.of(context).text.main.withAlpha(102) : Theme.of(context).text.main)),
              if(widget.description != null) ...[
                AppSize.xxsmall.gapHeight,
                AppText(widget.description!, style: Theme.of(context).textSRegular.copyWith(color: widget.disabled ? Theme.of(context).text.soft.withAlpha(102) :  Theme.of(context).text.soft)),
              ],
            if(widget.onTapLabel != null) ...[
              AppSize.xsmall.gapHeight,
              InkWell(onTap: widget.onTap, child: AppText(type: TextType.nonSelectable,widget.onTapLabel!, style: Theme.of(context).textMRegular.copyWith(color: widget.disabled ? Theme.of(context).text.subtle.withAlpha(102) : Theme.of(context).text.subtle) )),
              AppSize.xsmall.gapHeight,
            ]
          ],
        )
      ],
    );
  }
}
