import 'package:flutter/material.dart';
import 'package:framework_base/framework_base.dart';
import 'package:hugeicons/hugeicons.dart';

class DemoAppTextFormField extends StatelessWidget {
  const DemoAppTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController dateLardController = TextEditingController();
    TextEditingController dateMediumController = TextEditingController();
    TextEditingController dateSmallController = TextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Text Form Field', style: Theme.of(context).textLMedium),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSize.base.gapWidth,
            Expanded(
              child: AppTextFormField(
                size: AppTextFormFieldSize.large,
                label: 'متن لیبل',
                isRequired: true,
                enabled: true,
                showCharacterCount: true,
                hint: 'متن نمونه فیلد',
                helperText: 'در اینجا نکات مهم آورده می‌شود.',
                validator: (value) {
                  if (value!.length > 5) {
                    return null;
                  } else {
                    return "خطا حداقل تعداد کارکتر ۵ میباشد";
                  }
                },
                suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),

              )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.medium,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
              child: AppTextFormField(
                size: AppTextFormFieldSize.small,
                label: 'متن لیبل',
                isRequired: true,
                enabled: true,
                hint: 'متن نمونه فیلد',
                helperText: 'در اینجا نکات مهم آورده می‌شود.',
                validator: (value) {
                  if (value!.length > 5) {
                    return null;
                  } else {
                    return "خطا حداقل تعداد کارکتر ۵ میباشد";
                  }
                },
                suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
              )
            ),
            AppSize.xsmall.gapWidth,
          ],
        ),
        AppSize.xsmall.gapHeight,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSize.base.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.large,
                  type: AppTextFormFieldType.text,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),

                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.medium,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.small,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
          ],
        ),
        AppSize.xsmall.gapHeight,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSize.base.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.large,
                  type: AppTextFormFieldType.currency,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.medium,
                  type: AppTextFormFieldType.currency,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.small,
                  type: AppTextFormFieldType.currency,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
          ],
        ),
        AppSize.xsmall.gapHeight,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSize.base.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.large,
                  type: AppTextFormFieldType.currency,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.medium,
                  type: AppTextFormFieldType.currency,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.small,
                  type: AppTextFormFieldType.currency,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
          ],
        ),
        AppSize.xsmall.gapHeight,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSize.base.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.large,
                  type: AppTextFormFieldType.iban,
                  autoFontResize: true,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.medium,
                  type: AppTextFormFieldType.iban,
                  autoFontResize: true,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.small,
                  type: AppTextFormFieldType.iban,
                  autoFontResize: true,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
          ],
        ),
        AppSize.xsmall.gapHeight,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSize.base.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.large,
                  type: AppTextFormFieldType.iban,
                  autoFontResize: true,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.medium,
                  type: AppTextFormFieldType.iban,
                  autoFontResize: true,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.small,
                  type: AppTextFormFieldType.iban,
                  autoFontResize: true,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
          ],
        ),
        AppSize.xsmall.gapHeight,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSize.base.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.large,
                  type: AppTextFormFieldType.currency,
                  currency: AppTextFormFieldCurrency.dollar,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.medium,
                  type: AppTextFormFieldType.currency,
                  currency: AppTextFormFieldCurrency.dollar,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.small,
                  type: AppTextFormFieldType.currency,
                  currency: AppTextFormFieldCurrency.dollar,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
          ],
        ),
        AppSize.xsmall.gapHeight,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSize.base.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.large,
                  type: AppTextFormFieldType.currency,
                  currency: AppTextFormFieldCurrency.dollar,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.medium,
                  type: AppTextFormFieldType.currency,
                  currency: AppTextFormFieldCurrency.dollar,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.small,
                  type: AppTextFormFieldType.currency,
                  currency: AppTextFormFieldCurrency.dollar,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
          ],
        ),
        AppSize.xsmall.gapHeight,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSize.base.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.large,
                  type: AppTextFormFieldType.date,
                  controller: dateLardController,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  hint: 'روز / ماه / سال',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  onTap: (){

                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.medium,
                  type: AppTextFormFieldType.date,
                  controller: dateMediumController,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  hint: 'روز / ماه / سال',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  onTap: (){

                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.small,
                  type: AppTextFormFieldType.date,
                  controller: dateSmallController,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  hint: 'روز / ماه / سال',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  onTap: (){

                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                )
            ),
            AppSize.xsmall.gapWidth,
          ],
        ),
        AppSize.xsmall.gapHeight,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSize.base.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.large,
                  type: AppTextFormFieldType.date,
                  controller: dateLardController,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'روز / ماه / سال',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  onTap: (){

                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.medium,
                  type: AppTextFormFieldType.date,
                  controller: dateMediumController,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'روز / ماه / سال',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  onTap: (){

                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.small,
                  type: AppTextFormFieldType.date,
                  controller: dateSmallController,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'روز / ماه / سال',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  onTap: (){

                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                )
            ),
            AppSize.xsmall.gapWidth,
          ],
        ),
        AppSize.xsmall.gapHeight,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSize.base.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.large,
                  type: AppTextFormFieldType.password,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.medium,
                  type: AppTextFormFieldType.password,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.small,
                  type: AppTextFormFieldType.password,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                )
            ),
            AppSize.xsmall.gapWidth,
          ],
        ),
        AppSize.xsmall.gapHeight,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSize.base.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.large,
                  type: AppTextFormFieldType.password,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.medium,
                  type: AppTextFormFieldType.password,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.small,
                  type: AppTextFormFieldType.password,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
          ],
        ),
        AppSize.xsmall.gapHeight,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSize.base.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.large,
                  type: AppTextFormFieldType.textMultiline,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  maxLength: 255,
                  showCharacterCount: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),

                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.medium,
                  type: AppTextFormFieldType.textMultiline,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  maxLength: 255,
                  showCharacterCount: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.small,
                  type: AppTextFormFieldType.textMultiline,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  maxLength: 255,
                  showCharacterCount: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
          ],
        ),
        AppSize.xsmall.gapHeight,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSize.base.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.large,
                  type: AppTextFormFieldType.textMultiline,
                  label: 'متن لیبل',
                  // isRequired: true,
                  enabled: false,
                  maxLength: 255,
                  showCharacterCount: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),

                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.medium,
                  type: AppTextFormFieldType.textMultiline,
                  label: 'متن لیبل',
                  // isRequired: true,
                  enabled: false,
                  maxLength: 255,
                  showCharacterCount: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.small,
                  type: AppTextFormFieldType.textMultiline,
                  label: 'متن لیبل',
                  // isRequired: true,
                  enabled: false,
                  maxLength: 255,
                  showCharacterCount: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    if (value!.length > 5) {
                      return null;
                    } else {
                      return "خطا حداقل تعداد کارکتر ۵ میباشد";
                    }
                  },
                  suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                )
            ),
            AppSize.xsmall.gapWidth,
          ],
        ),
        AppSize.xsmall.gapHeight,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSize.base.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.large,
                  type: AppTextFormFieldType.dropdown,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    return null;
                  },
                  // suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  // prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                  onTap: (){
                    print('tap');
                  },
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.medium,
                  type: AppTextFormFieldType.dropdown,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  // suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  // prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                  onTap: (){
                    print('tap');
                  },
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.small,
                  type: AppTextFormFieldType.dropdown,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: true,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  // suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  // prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                  onTap: (){
                    print('tap');
                  },
                )
            ),
            AppSize.xsmall.gapWidth,
          ],
        ),
        AppSize.xsmall.gapHeight,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSize.base.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.large,
                  type: AppTextFormFieldType.dropdown,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  validator: (value) {
                    return null;
                  },
                  // suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  // prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                  onTap: (){
                    print('tap');
                  },
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.medium,
                  type: AppTextFormFieldType.dropdown,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  // suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  // prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                  onTap: (){
                    print('tap');
                  },
                )
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
                child: AppTextFormField(
                  size: AppTextFormFieldSize.small,
                  type: AppTextFormFieldType.dropdown,
                  label: 'متن لیبل',
                  isRequired: true,
                  enabled: false,
                  hint: 'متن نمونه فیلد',
                  helperText: 'در اینجا نکات مهم آورده می‌شود.',
                  // suffixWidget: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
                  // prefixWidget: HugeIcon(icon: HugeIcons.strokeRoundedUser),
                  onTap: (){
                    print('tap');
                  },
                )
            ),
            AppSize.xsmall.gapWidth,
          ],
        ),
        AppSize.xsmall.gapHeight,
      ],
    );
  }
}
