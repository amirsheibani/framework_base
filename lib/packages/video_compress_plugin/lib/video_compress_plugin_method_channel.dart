import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'video_compress_plugin_platform_interface.dart';

/// An implementation of [VideoCompressPluginPlatform] that uses method channels.
class MethodChannelVideoCompressPlugin extends VideoCompressPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('video_compress_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
