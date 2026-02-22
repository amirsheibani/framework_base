import 'package:cross_file/cross_file.dart';
import 'package:media_compressor/media_compressor.dart';

import 'video_compress_types.dart';

Future<XFile> transcodeVideo(
  XFile input, {
  VideoCompressQuality quality = VideoCompressQuality.medium,
  int rotate = 0,
}) async {
  final videoQuality = switch (quality) {
    VideoCompressQuality.low => VideoQuality.low,
    VideoCompressQuality.medium => VideoQuality.medium,
    VideoCompressQuality.high => VideoQuality.high,
  };

  final result = await MediaCompressor.compressVideo(
    VideoCompressionConfig(
      path: input.path,
      quality: videoQuality,
    ),
  );

  if (result.isSuccess && result.path != null) {
    return XFile(result.path!);
  }

  throw Exception('Compression video failed');
}
