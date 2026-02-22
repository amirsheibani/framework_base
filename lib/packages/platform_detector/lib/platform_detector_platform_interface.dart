import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'platform_detector_method_channel.dart';

abstract class PlatformDetectorPlatform extends PlatformInterface {
  /// Constructs a PlatformDetectorPlatform.
  PlatformDetectorPlatform() : super(token: _token);

  static final Object _token = Object();

  static PlatformDetectorPlatform _instance = MethodChannelPlatformDetector();

  /// The default instance of [PlatformDetectorPlatform] to use.
  ///
  /// Defaults to [MethodChannelPlatformDetector].
  static PlatformDetectorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PlatformDetectorPlatform] when
  /// they register themselves.
  static set instance(PlatformDetectorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<bool?> isAndroidPlatform() {
    throw UnimplementedError('isAndroidPlatform() has not been implemented.');
  }
  Future<bool?> isIOSPlatform() {
    throw UnimplementedError('isIOSPlatform() has not been implemented.');
  }
  Future<bool?> isMobilePlatform() {
    throw UnimplementedError('isMobilePlatform() has not been implemented.');
  }
  Future<bool?> isDevToolsOpen() {
    throw UnimplementedError('isDevToolsOpen() has not been implemented.');
  }
}
