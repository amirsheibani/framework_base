import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'package:framework_base/packages/framework_service/lib/src/motion_service_handler.dart';

void main() {
  test('MotionService emits MotionData when accelerometer events arrive',
      () async {
    final accController = StreamController<AccelerometerEvent>.broadcast();
    final gyroController = StreamController<GyroscopeEvent>.broadcast();

    final service = MotionService(
      accelerometerStream: accController.stream,
      gyroscopeStream: gyroController.stream,
    );

    final emitted = <MotionData>[];
    final sub = service.motionStream.listen(emitted.add);

    accController.add(AccelerometerEvent(0, 0, 9.8));
    await Future<void>.delayed(const Duration(milliseconds: 5));

    accController.add(AccelerometerEvent(0, 9.8, 0));
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(emitted.length, greaterThanOrEqualTo(2));

    await sub.cancel();
    await service.dispose();
    await accController.close();
    await gyroController.close();
  });

  test('MotionService stop() stops emitting new values until start()', () async {
    final accController = StreamController<AccelerometerEvent>.broadcast();
    final gyroController = StreamController<GyroscopeEvent>.broadcast();

    final service = MotionService(
      accelerometerStream: accController.stream,
      gyroscopeStream: gyroController.stream,
    );

    final emitted = <MotionData>[];
    final sub = service.motionStream.listen(emitted.add);

    accController.add(AccelerometerEvent(0, 0, 9.8));
    await Future<void>.delayed(const Duration(milliseconds: 10));

    await service.stop();

    final before = emitted.length;
    accController.add(AccelerometerEvent(0, 9.8, 0));
    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(emitted.length, before);

    service.start();
    accController.add(AccelerometerEvent(0, 9.8, 0));
    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(emitted.length, greaterThan(before));

    await sub.cancel();
    await service.dispose();
    await accController.close();
    await gyroController.close();
  });
}
