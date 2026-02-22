import 'dart:math';
import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:framework_base/framework_base.dart';
import 'package:image/image.dart' as img;

void main() {
  group('XFileExt', () {
    test('fileSizeStr returns 0 B for empty file', () async {
      final file = XFile.fromData(Uint8List(0));

      expect(await file.fileSizeStr(1), '0 B');
    });

    test('fileSizeStr formats kilobytes with decimals', () async {
      final file = XFile.fromData(Uint8List.fromList(List<int>.filled(1024, 0)));

      expect(await file.fileSizeStr(1), '1.0 KB');
    });

    test('fileSizeStr formats megabytes with decimals', () async {
      final file = XFile.fromData(Uint8List.fromList(List<int>.filled(pow(1024, 2).toInt(), 1)));

      expect(await file.fileSizeStr(2), '1.00 MB');
    });

    test('imageSize returns correct dimensions for an encoded image', () async {
      final image = img.Image(width: 4, height: 6);
      final bytes = img.encodePng(image);
      final file = XFile.fromData(Uint8List.fromList(bytes));

      final size = await file.imageSize;

      expect(size.width, 4.0);
      expect(size.height, 6.0);
    });
  });
}
