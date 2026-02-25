import 'dart:math';
import 'dart:ui';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:framework_base/packages/framework_utils/lib/src/extensions/uint8_list_extension.dart';
import 'package:image/image.dart';


extension XFileExt on XFile {
  Future<String> fileSizeStr(int decimals) async {
    int bytes = await length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();

    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  Future<int> get fileSize async {
    int bytes = await length();
    return bytes;
  }

  Future<Size> get imageSize async {
    final image = decodeImage(await readAsBytes());
    return Size(image?.width.toDouble() ?? 0.0, image?.height.toDouble() ?? 0.0);
  }

  Future<XFile?> cropImage({
    required double aspectRatio,
  }) async {
    final image = decodeImage(await readAsBytes());
    if (image == null) return null;

    const extraWidth = 26;
    final width = image.width - 26;
    final height = width / aspectRatio;
    final x = (extraWidth / 2).floor();
    final y = ((image.height / 2) - height / 2).floor();
    final thumbnail = copyCrop(image, x: x, y: y, width: width.ceil(), height: height.ceil());
    final imageEncode = encodeJpg(thumbnail);
    return XFile.fromData(imageEncode);
  }

   Future<String?> mimeFile() async {
    final Uint8List result = await readAsBytes();
    return result.mimeFile;
  }
}

