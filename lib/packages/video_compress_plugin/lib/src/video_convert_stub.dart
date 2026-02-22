import 'package:cross_file/cross_file.dart';

import 'video_compress_types.dart';

Future<XFile> transcodeVideo(
  XFile input, {
  VideoCompressQuality quality = VideoCompressQuality.medium,
  int rotate = 0,
}) {
  throw UnsupportedError('video_compress_plugin is not supported on this platform');
}
