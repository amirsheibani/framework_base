import 'dart:js_interop';
import 'package:flutter/foundation.dart';

@JS('navigator.userAgent')
external String get userAgent;

@JS('isDevToolsOpen')
external bool _isDevToolsOpenJs();
bool isMobilePlatform() {
  bool targetPlatformIsIos = defaultTargetPlatform == TargetPlatform.iOS;
  bool targetPlatformIsAndroid = defaultTargetPlatform == TargetPlatform.android;
  return kIsWeb && (targetPlatformIsIos || targetPlatformIsAndroid);
}

bool isDevToolsOpen() {
  if (!kIsWeb) return false;
  try {
    return _isDevToolsOpenJs();
  } catch (e) {
    return false;
  }
}