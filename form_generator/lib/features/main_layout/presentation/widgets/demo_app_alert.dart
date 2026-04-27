import 'package:flutter/material.dart';
import 'package:framework_base/framework_base.dart';
import 'package:hugeicons/hugeicons.dart';

class DemoAppAlert extends StatelessWidget {
  const DemoAppAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Alert Neutral', style: Theme.of(context).textLMedium),
        AppSize.xsmall.gapHeight,
        AppAlert(type: AppAlertType.neutral, title: 'خطا', description: "برای حساب‌های در وضعیت «بسته» امکان ایجاد حساب وجود ندارد. برای حساب‌های در وضعیت «بسته» امکان ایجاد حساب وجود ندارد. برای حساب‌های در وضعیت «بسته» امکان ایجاد حساب وجود ندارد.", confirmationTap: () {}, closeTap: () {},confirmationTitle: 'متوجه شدم', moreInformationTitle: "اطلاعات بیشتر", moreInformationTap: () {}),
        AppSize.xsmall.gapHeight,
        AppText('Alert Success', style: Theme.of(context).textLMedium),
        AppSize.xsmall.gapHeight,
        AppAlert(type: AppAlertType.success, title: 'خطا', description: " برای حساب‌های در وضعیت «بسته» امکان ایجاد حساب وجود ندارد . برای حساب‌های در وضعیت «بسته» امکان ایجاد حساب وجود ندارد.", confirmationTap: () {}, closeTap: () {},confirmationTitle: 'متوجه شدم', moreInformationTitle: "اطلاعات بیشتر", moreInformationTap: () {}),
        AppSize.xsmall.gapHeight,
        AppText('Alert Information', style: Theme.of(context).textLMedium),
        AppSize.xsmall.gapHeight,
        AppAlert(type: AppAlertType.info, title: 'خطا', description: "برای حساب‌های در وضعیت «بسته» امکان ایجاد حساب وجود ندارد.", confirmationTap: () {}, closeTap: () {},confirmationTitle: 'متوجه شدم', moreInformationTitle: "اطلاعات بیشتر", moreInformationTap: () {}),
        AppSize.xsmall.gapHeight,
        AppText('Alert Warning', style: Theme.of(context).textLMedium),
        AppSize.xsmall.gapHeight,
        AppAlert(type: AppAlertType.warning, title: 'خطا', description: "برای حساب‌های در وضعیت «بسته» امکان ایجاد حساب وجود ندارد.", confirmationTap: () {}, closeTap: () {},confirmationTitle: 'متوجه شدم', moreInformationTitle: "اطلاعات بیشتر", moreInformationTap: () {}),
        AppSize.xsmall.gapHeight,
        AppText('Alert Destructive', style: Theme.of(context).textLMedium),
        AppSize.xsmall.gapHeight,
        AppAlert(type: AppAlertType.destructive, title: 'خطا', description: "برای حساب‌های در وضعیت «بسته» امکان ایجاد حساب وجود ندارد.", confirmationTap: () {}, closeTap: () {},confirmationTitle: 'متوجه شدم', moreInformationTitle: "اطلاعات بیشتر", moreInformationTap: () {}),
        AppSize.xsmall.gapHeight,
      ],
    );
  }
}
