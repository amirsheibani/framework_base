import 'package:flutter/material.dart';
import 'package:framework_base/framework_base.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

enum AppAlertType { neutral, success, info, warning, destructive }

class AppAlert extends StatelessWidget {
  const AppAlert({super.key, required this.type, this.confirmationTap, this.moreInformationTap, this.closeTap, required this.title, required this.description, this.confirmationTitle, this.moreInformationTitle}):
        assert((confirmationTap == null) == (confirmationTitle == null),
        'Either provide both moreInformationTap and moreInformationTitle or neither.'),
        assert((moreInformationTap == null) == (moreInformationTitle == null),
        'Either provide both moreInformationTap and moreInformationTitle or neither.');

  final AppAlertType type;
  final VoidCallback? confirmationTap;
  final String? confirmationTitle;
  final VoidCallback? moreInformationTap;
  final String? moreInformationTitle;
  final VoidCallback? closeTap;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 448, minHeight: 120),
      decoration: BoxDecoration(
        color: () {
          return switch (type) {
            AppAlertType.neutral => Theme.of(context).backgroundSurface.subtle,
            AppAlertType.success => Theme.of(context).backgroundFunc.successLow,
            AppAlertType.info => Theme.of(context).backgroundFunc.infoLow,
            AppAlertType.warning => Theme.of(context).backgroundSurface.primaryLow,
            AppAlertType.destructive => Theme.of(context).backgroundFunc.destructiveLow,
          };
        }(),
        borderRadius: BorderRadius.circular(AppSize.small),
        border: Border.all(
          color: () {
            return switch (type) {
              AppAlertType.neutral => Theme.of(context).border.subtle,
              AppAlertType.success => Theme.of(context).border.success,
              AppAlertType.info => Theme.of(context).border.info,
              AppAlertType.warning => Theme.of(context).border.primary,
              AppAlertType.destructive => Theme.of(context).border.destructive,
            };
          }(),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.base),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HugeIcon(
              icon: HugeIconsStrokeRounded.informationCircle,
              color: () {
                return switch (type) {
                  AppAlertType.neutral => Theme.of(context).icon.sub,
                  AppAlertType.success => Theme.of(context).icon.success,
                  AppAlertType.info => Theme.of(context).icon.info,
                  AppAlertType.warning => Theme.of(context).icon.warning,
                  AppAlertType.destructive => Theme.of(context).icon.destructive,
                };
              }(),
              size: 20,
            ),
            AppSize.xsmall.gapWidth,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        title,
                        style: Theme.of(context).textMMedium.copyWith(
                          color: () {
                            return switch (type) {
                              AppAlertType.neutral => Theme.of(context).text.main,
                              AppAlertType.success => Theme.of(context).text.success,
                              AppAlertType.info => Theme.of(context).text.info,
                              AppAlertType.warning => Theme.of(context).text.warning,
                              AppAlertType.destructive => Theme.of(context).text.destructive,
                            };
                          }(),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: closeTap,
                        child: HugeIcon(icon: HugeIcons.strokeRoundedCancel01, size: 16, color: Theme.of(context).icon.sub),
                      ),
                    ],
                  ),
                  AppSize.xsmall.gapHeight,
                  Flexible(
                    child: AppText(description, style: Theme.of(context).textSRegular.copyWith(color: Theme.of(context).text.subtle)),
                  ),
                  AppSize.xsmall.gapHeight,
                  Row(
                    children: [
                      if (confirmationTap != null)
                        InkWell(
                          onTap: confirmationTap,
                          child: AppText(
                            confirmationTitle ?? '-',
                            style: Theme.of(context).textSRegular.copyWith(
                              decoration: TextDecoration.underline,
                              color: () {
                                return switch (type) {
                                  AppAlertType.neutral => Theme.of(context).text.main,
                                  AppAlertType.success => Theme.of(context).text.success,
                                  AppAlertType.info => Theme.of(context).text.info,
                                  AppAlertType.warning => Theme.of(context).text.warning,
                                  AppAlertType.destructive => Theme.of(context).text.destructive,
                                };
                              }(),
                            ),
                          ),
                        ),
                      if (moreInformationTap != null) ...[
                        AppSize.medium.gapWidth,
                        InkWell(
                          onTap: moreInformationTap,
                          child: AppText(moreInformationTitle ?? '-', style: Theme.of(context).textSRegular.copyWith(color: Theme.of(context).text.subtle)),
                        ),
                      ],
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
