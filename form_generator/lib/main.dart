import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:framework_base/framework_base.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app/app.dart';
import 'bootstrap.dart';

Future<void> main() async {


  const String mapboxToken = String.fromEnvironment('MAPBOX_TOKEN', defaultValue: '');

  WidgetsFlutterBinding.ensureInitialized();

  // HardwareKeyboard.instance.addHandler((event) {
  //   if (event is KeyDownEvent) {
  //     if (HardwareKeyboard.instance.physicalKeysPressed
  //         .contains(event.physicalKey)) {
  //       return true; // ignore duplicated keydown
  //     }
  //   }
  //   return false;
  // });

  environment = ProdEnvironment(
    // baseUrl: kIsWeb ? Uri.base.host : 'https://api.myip.com',
    baseUrl: 'https://api.myip.com',
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
}