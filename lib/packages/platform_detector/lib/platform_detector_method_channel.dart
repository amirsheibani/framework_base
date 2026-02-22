import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'platform_detector_platform_interface.dart';

/// An implementation of [PlatformDetectorPlatform] that uses method channels.
class MethodChannelPlatformDetector extends PlatformDetectorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('platform_detector');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> isAndroidPlatform() async {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android;
  }

  @override
  Future<bool?> isIOSPlatform() async {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.iOS;
  }

  @override
  Future<bool?> isMobilePlatform() async {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  @override
  Future<bool?> isDevToolsOpen() async {
    return false;
  }


}
