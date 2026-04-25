import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_generator/app/router.dart';
import 'package:form_generator/core/theme/app_theme.dart';
import 'package:form_generator/features/splash/presentation/manager/splash_provider.dart';
import 'package:framework_base/framework_base.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer(
      builder: (context, ref, child) {
        ref.listenManual(
            splashProvider,
                (pre, next) {
          next.whenOrNull(
            data: (value) {
              // context.go(AppRouterPath.gpsInfo.path);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.go(AppRouterPath.mainLayout.path);
              });
            },
          );
        },
        fireImmediately: true);
        return ref
                .watch(splashProvider)
                .whenOrNull(
                  loading: () {
                    return Placeholder(child: Center(child: CircularProgressIndicator()));
                  },
                ) ??
            Placeholder(
              child: Center(
                child: Text('صفحه اسپلش', style: Theme.of(context).textXLMedium.copyWith(color: Theme.of(context).text.destructive)),
              ),
            );
      },
    );
  }
}
