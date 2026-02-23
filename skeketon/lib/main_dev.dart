import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:framework_base/packages/framework_core/lib/core_framework.dart';
import 'package:skeleton/app/app.dart';
import 'package:skeleton/bootstrap.dart';
import 'package:sentry_flutter/sentry_flutter.dart';


Future<void> main() async {
  const String mapboxToken = String.fromEnvironment('MAPBOX_TOKEN', defaultValue: '');

  await SentryFlutter.init(
        (options) {
      options.dsn = 'https://90a12ffda665b302617ad48542ff110f@o4510023430897664.ingest.de.sentry.io/4510929350492240';
      options.sendDefaultPii = true;
      options.tracesSampleRate = 1.0;
      options.environment = 'dev';
      options.release = '1.0.0+1';
      options.serverName = 'dev';
    },
    appRunner: () async {
      WidgetsFlutterBinding.ensureInitialized();

      environment = DevEnvironment(
        baseUrl: kIsWeb ? Uri.base.origin : 'https://api.myip.com',
        // baseUrl: 'https://api.myip.com',
        apiVersion: '',
        mapToken: mapboxToken,
        appId: 'SKELETON',
        showRuntimeLog: true,
        showChucker: true,
        showPrettyLog: true,
        supabaseUrl: 'https://lavtjaupeeehoxrcdxbi.supabase.co',
        supabaseAnonKey: 'sb_publishable_aKD9mHNB8q6WSuVlTM33UA_GGlB_MEx',
      );

      await appConfiguration();

      runApp(
        const Banner(
          message: 'Dev ',
          location: BannerLocation.bottomStart,
          layoutDirection: TextDirection.ltr,
          textDirection: TextDirection.ltr,
          textStyle: TextStyle(color: Color(0xFFFFFFFF)),
          color: Color(0xFFFF5151),
          child: ProviderScope(child: App()),
        ),
      );
    },
  );
}
