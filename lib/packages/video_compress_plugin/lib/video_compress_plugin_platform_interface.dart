import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'video_compress_plugin_method_channel.dart';

abstract class VideoCompressPluginPlatform extends PlatformInterface {
  /// Constructs a VideoCompressPluginPlatform.
  VideoCompressPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static VideoCompressPluginPlatform _instance = MethodChannelVideoCompressPlugin();

  /// The default instance of [VideoCompressPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelVideoCompressPlugin].
  static VideoCompressPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [VideoCompressPluginPlatform] when
  /// they register themselves.
  static set instance(VideoCompressPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
