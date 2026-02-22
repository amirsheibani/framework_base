import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum PlatformName {
  android('Android'),
  iOS('iOS'),
  pwa('PWA');

  final String? value;
  const PlatformName(this.value);
}

@module
abstract class DeviceModule {
  @singleton
  DeviceInfo provideDeviceInfo() => DeviceInfo();
}

class DeviceInfo {
  String? brand;
  String? deviceName;
  String? serialNumber;
  PlatformName? platformName;
  String? version;
  String? buildNumber;
  String? buildSignature;
  bool haveGoogleService = false;

  Future<void> init() async {
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final packageInfo = await PackageInfo.fromPlatform();

      buildSignature = packageInfo.buildSignature;
      buildNumber = packageInfo.buildNumber;
      version = packageInfo.version;

      /// =========================
      /// 🌐 WEB
      /// =========================
      if (kIsWeb) {
        final webInfo = await deviceInfoPlugin.webBrowserInfo;

        brand = webInfo.browserName.name;
        deviceName = webInfo.userAgent;
        platformName = PlatformName.pwa;
        haveGoogleService = false;
      }

      /// =========================
      /// 🤖 ANDROID
      /// =========================
      else if (defaultTargetPlatform == TargetPlatform.android) {
        final androidInfo = await deviceInfoPlugin.androidInfo;

        brand = androidInfo.brand;
        deviceName = androidInfo.model;
        platformName = PlatformName.android;

        final result = await GoogleApiAvailability.instance
            .checkGooglePlayServicesAvailability();

        haveGoogleService =
            result == GooglePlayServicesAvailability.success;
      }

      /// =========================
      /// 🍎 iOS
      /// =========================
      else if (defaultTargetPlatform == TargetPlatform.iOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;

        brand = iosInfo.systemName;
        deviceName = iosInfo.model;
        platformName = PlatformName.iOS;

        haveGoogleService = false;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}