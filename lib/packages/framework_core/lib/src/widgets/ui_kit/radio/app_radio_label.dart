import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:framework_base/framework_base.dart';

class AppRadioLabel extends StatefulWidget {
  const AppRadioLabel({super.key, this.onChanged, this.initValue = false, required this.label, this.onTapLabel, this.onTap, this.description, this.size = AppRadioSize.small});
  final ValueChanged<bool>? onChanged;
  final bool initValue;
  final String label;
  final String? description;
  final String? onTapLabel;
  final VoidCallback? onTap;
  final AppRadioSize size;

  @override
  State<AppRadioLabel> createState() => _AppRadioLabelState();
}

class _AppRadioLabelState extends State<AppRadioLabel> {
  bool selected = false;


@override
  void didUpdateWidget(covariant AppRadioLabel oldWidget) {
    selected = widget.initValue;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppRadio(
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
            AppText(widget.label, style: Theme.of(context).textSRegular.copyWith(color: Theme.of(context).text.main)),
              if(widget.description != null) ...[
                AppSize.xxsmall.gapHeight,
                AppText(widget.description!, style: Theme.of(context).textSRegular.copyWith(color: Theme.of(context).text.soft)),
              ],
            if(widget.onTapLabel != null) ...[
              AppSize.xsmall.gapHeight,
              InkWell(onTap: widget.onTap, child: AppText(type: TextType.nonSelectable,widget.onTapLabel!, style: Theme.of(context).textMRegular.copyWith(color: Theme.of(context).text.subtle))),
              AppSize.xsmall.gapHeight,
            ]
          ],
        )
      ],
    );
  }
}
