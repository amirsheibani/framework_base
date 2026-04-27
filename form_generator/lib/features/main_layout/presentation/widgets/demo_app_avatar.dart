import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:framework_base/framework_base.dart';
import 'package:hugeicons/hugeicons.dart';

class DemoAppAvatar extends StatelessWidget {
  const DemoAppAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Avatar', style: Theme.of(context).textLMedium),
        AppSize.xsmall.gapHeight,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppSize.xsmall.gapWidth,
            AppAvatar(size : AppAvatarSize.extraLarge,),
            AppSize.xsmall.gapWidth,
            AppAvatar(size : AppAvatarSize.large,),
            AppSize.xsmall.gapWidth,
            AppAvatar(size : AppAvatarSize.medium,),
            AppSize.xsmall.gapWidth,
            AppAvatar(size : AppAvatarSize.small,),
            AppSize.xsmall.gapWidth,
            AppAvatar(size : AppAvatarSize.extraSmall,),
            AppSize.xsmall.gapWidth,
          ],
        ),
        AppSize.xsmall.gapHeight,
        AppText('Avatar name', style: Theme.of(context).textLMedium),
        AppSize.xsmall.gapHeight,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppSize.xsmall.gapWidth,
            AppAvatar(size : AppAvatarSize.extraLarge,data: 'امیر',),
            AppSize.xsmall.gapWidth,
            AppAvatar(size : AppAvatarSize.large,data: 'بهرام',),
            AppSize.xsmall.gapWidth,
            AppAvatar(size : AppAvatarSize.medium,data: 'طاها',),
            AppSize.xsmall.gapWidth,
            AppAvatar(size : AppAvatarSize.small,data: 'پرهام',),
            AppSize.xsmall.gapWidth,
            AppAvatar(size : AppAvatarSize.extraSmall,data: 'جواد',),
            AppSize.xsmall.gapWidth,
          ],
        ),
        AppSize.xsmall.gapHeight,
        AppText('Avatar image byte', style: Theme.of(context).textLMedium),
        AppSize.xsmall.gapHeight,
        FutureBuilder(
          future: rootBundle.load('assets/images/avatar.jpg'),
          builder: (context, asyncSnapshot) {
            return asyncSnapshot.hasData ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppSize.xsmall.gapWidth,
                AppAvatar(size : AppAvatarSize.extraLarge,avatarByte: asyncSnapshot.data?.buffer.asUint8List(),),
                AppSize.xsmall.gapWidth,
                AppAvatar(size : AppAvatarSize.large,avatarByte: asyncSnapshot.data?.buffer.asUint8List(),),
                AppSize.xsmall.gapWidth,
                AppAvatar(size : AppAvatarSize.medium,avatarByte: asyncSnapshot.data?.buffer.asUint8List(),),
                AppSize.xsmall.gapWidth,
                AppAvatar(size : AppAvatarSize.small,avatarByte: asyncSnapshot.data?.buffer.asUint8List(),),
                AppSize.xsmall.gapWidth,
                AppAvatar(size : AppAvatarSize.extraSmall,avatarByte: asyncSnapshot.data?.buffer.asUint8List(),),
                AppSize.xsmall.gapWidth,
              ],
            ) : SizedBox();
          }
        ),
        AppSize.xsmall.gapHeight,
        AppText('Avatar image network', style: Theme.of(context).textLMedium),
        AppSize.xsmall.gapHeight,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppSize.xsmall.gapWidth,
            AppAvatar(size : AppAvatarSize.extraLarge,baseUrl: Uri.tryParse("https://avatar.iran.liara.run/public/1"),),
            AppSize.xsmall.gapWidth,
            AppAvatar(size : AppAvatarSize.large,baseUrl: Uri.tryParse("https://avatar.iran.liara.run/public/1"),),
            AppSize.xsmall.gapWidth,
            AppAvatar(size : AppAvatarSize.medium,baseUrl: Uri.tryParse("https://avatar.iran.liara.run/public/1"),),
            AppSize.xsmall.gapWidth,
            AppAvatar(size : AppAvatarSize.small,baseUrl: Uri.tryParse("https://avatar.iran.liara.run/public/1"),),
            AppSize.xsmall.gapWidth,
            AppAvatar(size : AppAvatarSize.extraSmall,baseUrl: Uri.tryParse("https://avatar.iran.liara.run/public/1"),),
            AppSize.xsmall.gapWidth,
          ],
        ),
        AppSize.xsmall.gapHeight,
      ],
    );
  }
}
