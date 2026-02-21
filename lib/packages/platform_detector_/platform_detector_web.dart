import 'dart:js_interop';
import 'package:flutter/foundation.dart';

@JS('navigator.userAgent')
external JSString get _userAgent;

@JS('isDevToolsOpen')
external JSBoolean _isDevToolsOpenJs();

String get userAgent => _userAgent.toDart;

bool isMobilePlatform() {
  bool targetPlatformIsIos = defaultTargetPlatform == TargetPlatform.iOS;
  bool targetPlatformIsAndroid = defaultTargetPlatform == TargetPlatform.android;
  return kIsWeb && (targetPlatformIsIos || targetPlatformIsAndroid);
}

bool isIOSPlatform() {
  return defaultTargetPlatform == TargetPlatform.iOS;
}

bool isAndroidPlatform() {
  return defaultTargetPlatform == TargetPlatform.android;
}

bool isDevToolsOpen() {
  if (!kIsWeb) return false;
  try {
    return _isDevToolsOpenJs().toDart;
  } catch (e) {
    return false;
  }
}
