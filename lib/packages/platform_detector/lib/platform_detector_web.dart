import 'dart:js_interop';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'platform_detector_platform_interface.dart';

@JS('navigator.userAgent')
external JSString get _userAgent;

@JS('isDevToolsOpen')
external JSBoolean _isDevToolsOpenJs();

String get userAgent => _userAgent.toDart;


class PlatformDetectorWeb extends PlatformDetectorPlatform {
  static void registerWith(Registrar registrar) {
    PlatformDetectorPlatform.instance = PlatformDetectorWeb();
  }

  @override
  Future<String?> getPlatformVersion() async {
    return 'Web ($userAgent)';
  }
  @override
  Future<bool?> isAndroidPlatform() async {
    return defaultTargetPlatform == TargetPlatform.android;
  }
  @override
  Future<bool?> isIOSPlatform() async {
    return defaultTargetPlatform == TargetPlatform.iOS;
  }
  @override
  Future<bool?> isMobilePlatform() async {
    bool targetPlatformIsIos = defaultTargetPlatform == TargetPlatform.iOS;
    bool targetPlatformIsAndroid = defaultTargetPlatform == TargetPlatform.android;
    return kIsWeb && (targetPlatformIsIos || targetPlatformIsAndroid);
  }
  @override
  Future<bool?> isDevToolsOpen() async {
    if (!kIsWeb) return false;
    try {
      return _isDevToolsOpenJs().toDart;
    } catch (e) {
      return false;
    }
  }
}
