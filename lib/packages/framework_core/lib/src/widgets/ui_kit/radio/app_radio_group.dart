import 'package:flutter/material.dart';
import 'package:framework_base/framework_base.dart';
import 'app_radio.dart';
import 'model/app_radio_data.dart';




class AppRadioGroup extends StatefulWidget {


  const AppRadioGroup({super.key,required this.data,  this.separatorBuilder,this.shrinkWrap = false, this.radioSize = AppRadioSize.small, this.controller, this.physics, required this.itemSelected}): assert(data.length > 2);

  const AppRadioGroup.fixed({super.key, required this.data,  this.separatorBuilder, required this.itemSelected,this.shrinkWrap = true, this.controller, this.physics = const NeverScrollableScrollPhysics(), this.radioSize = AppRadioSize.small,}) : assert(data.length > 2);

  final IndexedWidgetBuilder? separatorBuilder;
  final bool shrinkWrap;
  final List<AppRadioData> data;
  final AppRadioSize radioSize;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final ValueChanged<int> itemSelected;

  @override
  State<AppRadioGroup> createState() => _AppRadioGroupState();
}

class _AppRadioGroupState extends State<AppRadioGroup> {
  int itemSelected = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: widget.controller,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      itemBuilder: (context, index) {
        return AppRadioLabel(
          initValue:  itemSelected == index,
          size: widget.radioSize,
          label: widget.data[index].title,
          description: widget.data[index].description,
          onChanged: (value) {
            itemSelected = index;
            setState(() {});
            widget.itemSelected(itemSelected);
          },
        );
      },
      separatorBuilder: widget.separatorBuilder ?? (_,_) =>  AppSize.xsmall.gapHeight,
      itemCount: widget.data.length,
    );
  }
}
