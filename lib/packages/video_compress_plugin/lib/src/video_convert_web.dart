import 'dart:js_interop';
import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';

import 'video_compress_types.dart';

@JS('transcode')
external JSPromise<JSArrayBuffer> _transcode(JSAny inputArrayBuffer, int rotate);

@JS('checkFFmpegVersion')
external JSPromise _checkFFmpegVersion();

Future<XFile> transcodeVideo(
  XFile input, {
  VideoCompressQuality quality = VideoCompressQuality.medium,
  int rotate = 0,
}) async {
  final bytes = await input.readAsBytes();

  await _checkFFmpegVersion().toDart;
  final resultBuffer = await _transcode(bytes.toJS, rotate).toDart;

  return XFile.fromData(
    Uint8List.view(resultBuffer.toDart),
    mimeType: 'video/mp4',
  );
}
