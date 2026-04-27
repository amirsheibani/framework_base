import 'package:flutter/material.dart';
import 'app_radio_tile.dart';
import 'app_radio.dart';
import '../gap/app_size.dart';
import 'model/app_radio_data.dart';



class AppRadioList extends StatefulWidget {
  const AppRadioList({super.key,required this.data,  this.separatorBuilder, required this.itemSelected,this.shrinkWrap = false, this.controller, this.physics}): assert(data.length > 2);

  final IndexedWidgetBuilder? separatorBuilder;
  final ValueChanged<int> itemSelected;
  final bool shrinkWrap;
  final List<AppRadioData> data;
  final ScrollController? controller;
  final ScrollPhysics? physics;

  const AppRadioList.fixed({super.key, required this.data,  this.separatorBuilder, required this.itemSelected,this.shrinkWrap = true, this.controller, this.physics = const NeverScrollableScrollPhysics()}) : assert(data.length > 2);
  @override
  State<AppRadioList> createState() => _AppRadioListState();
}

class _AppRadioListState extends State<AppRadioList> {
  int itemSelected = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: widget.controller,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      itemBuilder: (context, index) {
        return AppRadioTile(
          initValue: itemSelected == index,
          size: AppRadioSize.large,
          title: widget.data[index].title,
          trailing: widget.data[index].trailing,
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
