import 'package:flutter/material.dart';
import 'app_switch_tile.dart';
import 'app_switch.dart';
import '../gap/app_size.dart';

class AppSwitchData{
  final String title;
  final String? description;
  final Widget? trailing;

  AppSwitchData({required this.title, this.description, this.trailing});
}

class AppSwitchList extends StatefulWidget {
  const AppSwitchList({super.key,required this.data,  this.separatorBuilder, required this.itemSelected,this.shrinkWrap = false, this.controller, this.physics}): assert(data.length > 2);

  final IndexedWidgetBuilder? separatorBuilder;
  final ValueChanged<int> itemSelected;
  final bool shrinkWrap;
  final List<AppSwitchData> data;
  final ScrollController? controller;
  final ScrollPhysics? physics;

  const AppSwitchList.fixed({super.key, required this.data,  this.separatorBuilder, required this.itemSelected,this.shrinkWrap = true, this.controller, this.physics = const NeverScrollableScrollPhysics()}) : assert(data.length > 2);
  @override
  State<AppSwitchList> createState() => _AppSwitchListState();
}

class _AppSwitchListState extends State<AppSwitchList> {
  int itemSelected = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: widget.controller,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      itemBuilder: (context, index) {
        return AppSwitchTile(
          initValue: itemSelected == index,
          size: AppSwitchSize.large,
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
