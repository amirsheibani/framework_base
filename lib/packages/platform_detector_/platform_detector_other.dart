import 'dart:io' show Platform;

bool isMobilePlatform() {
  return Platform.isAndroid || Platform.isIOS;
}

bool isIOSPlatform() {
  return Platform.isIOS;
}


bool isAndroidPlatform() {
  return Platform.isAndroid;
}