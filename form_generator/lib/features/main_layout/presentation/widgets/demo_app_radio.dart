import 'package:flutter/material.dart';
import 'package:framework_base/framework_base.dart';

class DemoAppRadio extends StatefulWidget {
  const DemoAppRadio({super.key});

  @override
  State<DemoAppRadio> createState() => _DemoAppRadioState();
}

class _DemoAppRadioState extends State<DemoAppRadio> {
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
          AppText('Radio small', style: Theme.of(context).textLMedium),
          AppSize.xsmall.gapHeight,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSize.xsmall.gapWidth,
              AppRadio(
                selected: lineOne,
                size: AppRadioSize.small,
                onChanged: (value) {
                  setState(() {
                    lineOne = value;
                  });
                },
              ),
              AppSize.xsmall.gapWidth,
              AppRadio(
                selected: !lineOne,
                size: AppRadioSize.small,
                onChanged: (value) {
                  setState(() {
                    lineOne = !value;
                  });
                },
              ),
              AppSize.xsmall.gapWidth,
            ],
          ),
          AppSize.xsmall.gapHeight,
          AppText('Radio small disabled', style: Theme.of(context).textLMedium),
          AppSize.xsmall.gapHeight,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSize.xsmall.gapWidth,
              AppRadio(selected: lineTwo, size: AppRadioSize.small, disabled: true),
              AppSize.xsmall.gapWidth,
              AppRadio(selected: !lineTwo, size: AppRadioSize.small, disabled: true),
              AppSize.xsmall.gapWidth,
            ],
          ),
          AppSize.xsmall.gapHeight,
          AppText('Radio large', style: Theme.of(context).textLMedium),
          AppSize.xsmall.gapHeight,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSize.xsmall.gapWidth,
              AppRadio(
                selected: lineThree,
                size: AppRadioSize.large,
                onChanged: (value) {
                  setState(() {
                    lineThree = value;
                  });
                },
              ),
              AppSize.xsmall.gapWidth,
              AppRadio(
                selected: !lineThree,
                size: AppRadioSize.large,
                onChanged: (value) {
                  setState(() {
                    lineThree = !value;
                  });
                },
              ),
              AppSize.xsmall.gapWidth,
            ],
          ),
          AppSize.xsmall.gapHeight,
          AppText('Radio large disabled', style: Theme.of(context).textLMedium),
          AppSize.xsmall.gapHeight,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSize.xsmall.gapWidth,
              AppRadio(selected: lineFour, size: AppRadioSize.large, disabled: true),
              AppSize.xsmall.gapWidth,
              AppRadio(selected: !lineFour, size: AppRadioSize.large, disabled: true),
              AppSize.xsmall.gapWidth,
            ],
          ),
          AppSize.xsmall.gapHeight,
          AppText('Radio label', style: Theme.of(context).textLMedium),
          AppSize.xsmall.gapHeight,
          AppRadioLabel(label: 'متن لیبل', onTapLabel: 'دکمه لینک', onTap: () {}, description: "در اینجا توضیحات مرتبط با این کامپوننت میاد.", onChanged: (value) {}),
          AppSize.xsmall.gapHeight,
          AppText('RadioTile', style: Theme.of(context).textLMedium),
          AppSize.xsmall.gapHeight,
          AppRadioTile(title: 'متن لیبل', description: 'در اینجا توضیحات مرتبط با این کامپوننت میاد.', onChanged: (value) {}),
          AppSize.xsmall.gapHeight,
          AppRadioTile(size: AppRadioSize.large, title: 'متن لیبل', description: 'در اینجا توضیحات مرتبط با این کامپوننت میاد.', onChanged: (value) {}),
          AppSize.xsmall.gapHeight,
          AppRadioTile(
            title: 'متن لیبل',
            trailing: AppAvatar(size: AppAvatarSize.large, baseUrl: Uri.tryParse("https://avatar.iran.liara.run/public/1")),
            description: 'در اینجا توضیحات مرتبط با این کامپوننت میاد.',
            onChanged: (value) {},
          ),
          AppSize.xsmall.gapHeight,
          AppRadioTile(
            size: AppRadioSize.large,
            title: 'متن لیبل',
            trailing: AppAvatar(size: AppAvatarSize.large, data: 'Amir'),
            description: 'در اینجا توضیحات مرتبط با این کامپوننت میاد.',
            onChanged: (value) {},
          ),

          AppSize.xsmall.gapHeight,
          AppText('AppRadioList', style: Theme.of(context).textLMedium),
          AppSize.xsmall.gapHeight,
          AppRadioList.fixed(
              data: [
            AppRadioData(title: 'لیبل 1',description: 'در اینجا توضیحات مرتبط با این کامپوننت میاد.',trailing: AppAvatar(size: AppAvatarSize.large, data: 'Amir'),),
            AppRadioData(title: 'لیبل 2',description: 'در اینجا توضیحات مرتبط با این کامپوننت میاد.',trailing: AppAvatar(size: AppAvatarSize.large, data: 'Amir'),),
            AppRadioData(title: 'لیبل 3',description: 'در اینجا توضیحات مرتبط با این کامپوننت میاد.',trailing: AppAvatar(size: AppAvatarSize.large, data: 'Amir'),),
          ], itemSelected: (value){
            print(value);
          },
          ),

          AppSize.xsmall.gapHeight,
          AppText('AppRadioGroup', style: Theme.of(context).textLMedium),
          AppSize.xsmall.gapHeight,
          AppRadioGroup.fixed(
            data: [
              AppRadioData(title: 'لیبل 1'),
              AppRadioData(title: 'لیبل 2'),
              AppRadioData(title: 'لیبل 3'),
            ], itemSelected: (value){
            print(value);
          },
          )
        ],
      ),
    );
  }
}
