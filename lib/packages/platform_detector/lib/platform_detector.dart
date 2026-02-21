import 'platform_detector_platform_interface.dart';

class PlatformDetector {
  Future<String?> getPlatformVersion() {
    return PlatformDetectorPlatform.instance.getPlatformVersion();
  }
  Future<bool?> isAndroidPlatform() {
    return PlatformDetectorPlatform.instance.isAndroidPlatform();
  }
  Future<bool?> isIOSPlatform() {
    return PlatformDetectorPlatform.instance.isIOSPlatform();
  }
  Future<bool?> isMobilePlatform() {
    return PlatformDetectorPlatform.instance.isMobilePlatform();
  }
  Future<bool?> isDevToolsOpen() {
    return PlatformDetectorPlatform.instance.isDevToolsOpen();
  }
}