import 'package:flutter/material.dart';
import 'package:framework_base/framework_base.dart';

class DemoAppSwitch extends StatefulWidget {
  const DemoAppSwitch({super.key});

  @override
  State<DemoAppSwitch> createState() => _DemoAppSwitchState();
}

class _DemoAppSwitchState extends State<DemoAppSwitch> {
  bool lineOne = false;
  bool lineTwo = false;
  bool lineThree = false;
  bool lineFour = false;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 400),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText('Switch small', style: Theme.of(context).textLMedium),
          Row(
            children: [
              AppSwitch(size:AppSwitchSize.small,selected: true, onChanged: (value){}),
              AppSize.xsmall.gapWidth,
              AppSwitch(size:AppSwitchSize.small,selected: true, onChanged: (value){}),
            ],
          ),
          AppSize.xsmall.gapHeight,
          AppText('Switch large', style: Theme.of(context).textLMedium),
          Row(
            children: [
              AppSwitch(size:AppSwitchSize.large,selected: false, onChanged: (value){}),
              AppSize.xsmall.gapWidth,
              AppSwitch(size:AppSwitchSize.large,selected: false, onChanged: (value){}),
            ],
          ),
          AppSize.xsmall.gapHeight,
          AppText('Switch large', style: Theme.of(context).textLMedium),
          Row(
            children: [
              AppSwitch(size:AppSwitchSize.large,selected: false, onChanged: (value){},disabled: true,),
              AppSize.xsmall.gapWidth,
              AppSwitch(size:AppSwitchSize.large,selected: true, onChanged: (value){},disabled: true,),
            ],
          ),
          AppSize.xsmall.gapHeight,
          AppText('Switch label', style: Theme.of(context).textLMedium),
          AppSize.xsmall.gapHeight,
          AppSwitchLabel(label: 'متن لیبل', onTapLabel: 'دکمه لینک', onTap: () {}, description: "در اینجا توضیحات مرتبط با این کامپوننت میاد.", onChanged: (value) {}),
          AppSize.xsmall.gapHeight,
          AppText('SwitchTile', style: Theme.of(context).textLMedium),
          AppSize.xsmall.gapHeight,
          AppSwitchTile(title: 'متن لیبل',initValue: true,disabled: true, description: 'در اینجا توضیحات مرتبط با این کامپوننت میاد.', onChanged: (value) {}),
          AppSize.xsmall.gapHeight,
          AppSwitchTile(size: AppSwitchSize.large, title: 'متن لیبل', description: 'در اینجا توضیحات مرتبط با این کامپوننت میاد.', onChanged: (value) {}),
          AppSize.xsmall.gapHeight,
          AppSwitchTile(
            title: 'متن لیبل',
            initValue: false,disabled: true,
            trailing: AppAvatar(size: AppAvatarSize.large, baseUrl: Uri.tryParse("https://avatar.iran.liara.run/public/1")),
            description: 'در اینجا توضیحات مرتبط با این کامپوننت میاد.',
            onChanged: (value) {},
          ),
          AppSize.xsmall.gapHeight,
          AppSwitchTile(
            size: AppSwitchSize.large,
            title: 'متن لیبل',
            trailing: AppAvatar(size: AppAvatarSize.large, data: 'Amir'),
            description: 'در اینجا توضیحات مرتبط با این کامپوننت میاد.',
            onChanged: (value) {},
          ),

          AppSize.xsmall.gapHeight,
          AppText('AppSwitchList', style: Theme.of(context).textLMedium),
          AppSize.xsmall.gapHeight,
          AppSwitchList.fixed(
            data: [
              AppSwitchData(title: 'لیبل 1',description: 'در اینجا توضیحات مرتبط با این کامپوننت میاد.',trailing: AppAvatar(size: AppAvatarSize.large, data: 'Amir'),),
              AppSwitchData(title: 'لیبل 2',description: 'در اینجا توضیحات مرتبط با این کامپوننت میاد.',trailing: AppAvatar(size: AppAvatarSize.large, data: 'Amir'),),
              AppSwitchData(title: 'لیبل 3',description: 'در اینجا توضیحات مرتبط با این کامپوننت میاد.',trailing: AppAvatar(size: AppAvatarSize.large, data: 'Amir'),),
            ], itemSelected: (value){
            print(value);
          },
          ),

          AppSize.xsmall.gapHeight,
          // AppText('AppSwitchGroup', style: Theme.of(context).textLMedium),
          // AppSize.xsmall.gapHeight,
          // AppRadioGroup.fixed(
          //   data: [
          //     AppRadioData(title: 'لیبل 1'),
          //     AppRadioData(title: 'لیبل 2'),
          //     AppRadioData(title: 'لیبل 3'),
          //   ], itemSelected: (value){
          //   print(value);
          // },
          // )
        ],
      ),
    );
  }
}
