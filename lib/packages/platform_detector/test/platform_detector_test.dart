import 'package:flutter_test/flutter_test.dart';
import 'package:platform_detector/platform_detector.dart';
import 'package:platform_detector/platform_detector_platform_interface.dart';
import 'package:platform_detector/platform_detector_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPlatformDetectorPlatform extends PlatformDetectorPlatform
    with MockPlatformInterfaceMixin {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool?> isAndroidPlatform() => Future.value(false);

  @override
  Future<bool?> isIOSPlatform() => Future.value(false);

  @override
  Future<bool?> isMobilePlatform() => Future.value(false);

  @override
  Future<bool?> isDevToolsOpen() => Future.value(false);
}

void main() {
  final PlatformDetectorPlatform initialPlatform = PlatformDetectorPlatform.instance;

  test('$MethodChannelPlatformDetector is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPlatformDetector>());
  });

  test('getPlatformVersion', () async {
    PlatformDetector platformDetectorPlugin = PlatformDetector();
    MockPlatformDetectorPlatform fakePlatform = MockPlatformDetectorPlatform();
    PlatformDetectorPlatform.instance = fakePlatform;

    expect(await platformDetectorPlugin.getPlatformVersion(), '42');
  });
}
