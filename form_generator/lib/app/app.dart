

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_generator/app/app_lifecycle_widget.dart';
import 'package:form_generator/app/router.dart';
import 'package:form_generator/core/config/locale_configs.dart';
import 'package:form_generator/core/theme/app_theme.dart';
import 'package:form_generator/generated/l10n.dart';
import 'package:framework_base/framework_base.dart';
import 'package:framework_base/packages/framework_core/lib/core_framework.dart';


class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {


  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);

    final ThemeData baseTheme = switch (themeState.type) {
      ThemeType.light => ThemeData(
          fontFamily: 'IRANSansXFaNum',
          brightness: Brightness.light
      ),
      ThemeType.dark => ThemeData(
          fontFamily: 'IRANSansXFaNum',
          brightness: Brightness.dark
      ),
      ThemeType.system => ThemeData(brightness: MediaQuery.platformBrightnessOf(context)),
    };
    // اعمال تم سفارشی (پالت، bottom nav، و...) از app_theme
    final ThemeData theme = baseTheme.theme(null);

    return kIsWeb ? DismissibleKeyboard(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: LocaleConfigs.localizationsDelegates,
        routerConfig: appRouter,
        theme: theme,
        locale: Locale('fa'),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0),
            ),
            child: DefaultTextStyle(
              style: const TextStyle(fontFamily: 'IRANSansXFaNum'),
              child: child ?? const SizedBox(),
            ),
          );
        },
      ),
    ) :AppLifecycleWidget(
      child: DismissibleKeyboard(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: LocaleConfigs.localizationsDelegates,
          routerConfig: appRouter,
          theme: theme,
          locale: Locale('fa'),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
              ),
              child: DefaultTextStyle(
                style: const TextStyle(fontFamily: 'IRANSansXFaNum'),
                child: child ?? const SizedBox(),
              ),
            );
          },
        ),
      ),
    );
  }
}


