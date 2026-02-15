import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:framework_base/packages/framework_handler/lib/src/service/gps_service_handler.dart';

class _MockGeolocator extends Mock implements GeolocatorPlatform {}

void main() {
  setUpAll(() {
    registerFallbackValue(const LocationSettings());
  });

  test('GPSService.checkPermissionStatus returns granted when permission is granted',
      () async {
    final geolocator = _MockGeolocator();

    final permission = Permission.location;

    final service = GPSService(
      geolocator: geolocator,
      locationPermission: permission,
    );

    final status = await service.checkPermissionStatus();
    expect(status, isIn([GPSPermissionStatus.granted, GPSPermissionStatus.denied, GPSPermissionStatus.deniedForever, GPSPermissionStatus.checking]));
  });

  test('GPSService.getCurrentPosition returns null when requestPermission is denied',
      () async {
    final geolocator = _MockGeolocator();

    final permission = Permission.location;

    when(() => geolocator.checkPermission())
        .thenAnswer((_) async => LocationPermission.denied);
    when(() => geolocator.requestPermission())
        .thenAnswer((_) async => LocationPermission.denied);

    final service = GPSService(
      geolocator: geolocator,
      locationPermission: permission,
    );

    final pos = await service.getCurrentPosition();
    expect(pos, isNull);

    verifyNever(() => geolocator.getCurrentPosition(locationSettings: any(named: 'locationSettings')));
  });

  test('GPSService.startListening subscribes to position stream and emits positions',
      () async {
    final geolocator = _MockGeolocator();

    final permission = Permission.location;

    when(() => geolocator.checkPermission())
        .thenAnswer((_) async => LocationPermission.always);

    final controller = StreamController<Position>.broadcast();
    when(() => geolocator.getPositionStream(locationSettings: any(named: 'locationSettings')))
        .thenAnswer((_) => controller.stream);

    final service = GPSService(
      geolocator: geolocator,
      locationPermission: permission,
    );

    final emitted = <Position>[];
    final sub = service.positionStream.listen(emitted.add);

    final started = await service.startListening();
    expect(started, isTrue);

    final position = Position(
      latitude: 1,
      longitude: 2,
      timestamp: DateTime.fromMillisecondsSinceEpoch(0),
      accuracy: 1,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0,
    );

    controller.add(position);
    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(emitted, hasLength(1));
    expect(emitted.first.latitude, 1);
    expect(service.lastKnownPosition, isNotNull);

    await sub.cancel();
    await controller.close();
    service.dispose();
  });
}
