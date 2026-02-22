
import 'package:cross_file/cross_file.dart';

import 'src/video_compress_types.dart';
import 'src/video_convert.dart' as impl;
import 'video_compress_plugin_platform_interface.dart';

export 'src/video_compress_types.dart' show VideoCompressQuality;

class VideoCompressPlugin {
  Future<String?> getPlatformVersion() {
    return VideoCompressPluginPlatform.instance.getPlatformVersion();
  }

  Future<XFile> compressVideo(
    XFile input, {
    VideoCompressQuality quality = VideoCompressQuality.medium,
    int rotate = 0,
  }) {
    return impl.transcodeVideo(
      input,
      quality: quality,
      rotate: rotate,
    );
  }
}
