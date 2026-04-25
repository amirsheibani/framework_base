import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:form_generator/core/di/base/di_setup.dart';
import 'package:framework_base/framework_base.dart';
import 'package:framework_base/packages/framework_core/lib/core_framework.dart';
import 'package:framework_base/packages/framework_utils/lib/utils_framework.dart';
import 'package:permission_handler/permission_handler.dart';

late Environment environment;
late String sslCert;
late String authToken;
const platformChannel = MethodChannel('top.amirdeveloper.plugins');

Future<void> appConfiguration() async {

  sslCert = '';

  await configureDependencies();

  final deviceInfo = getIt<DeviceInfo>();
  await deviceInfo.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await requestNotificationPermission();

  FormEngine.initialize();

}



Future<void> requestNotificationPermission() async {
  final deviceInfo = getIt<DeviceInfo>();
  if(!kIsWeb && deviceInfo.platformName != PlatformName.macOS){
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }
}


