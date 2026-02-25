import 'package:flutter/foundation.dart';
import 'package:mime/mime.dart';

extension Uint8ListExt on Uint8List {
  String? get mimeFile {
    final mimeType = lookupMimeType(
      '',
      headerBytes: take(16).toList(),
    );
    return mimeType;
  }
}