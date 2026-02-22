//@GeneratedMicroModule;FrameworkBasePackageModule;package:framework_base/di/framework_base_micro.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:framework_base/packages/framework_handler/lib/src/service/car_slope_service.dart'
    as _i1056;
import 'package:framework_base/packages/framework_handler/lib/src/service/gps_service_handler.dart'
    as _i373;
import 'package:framework_base/packages/framework_handler/lib/src/service/internet_service_handler.dart'
    as _i23;
import 'package:framework_base/packages/framework_handler/lib/src/service/motion_service_handler.dart'
    as _i890;
import 'package:framework_base/packages/framework_handler/lib/src/service/nfc_service_handler.dart'
    as _i927;
import 'package:framework_base/packages/framework_handler/lib/src/service/supabase_auth_service_handler.dart'
    as _i708;
import 'package:framework_base/packages/framework_utils/lib/src/device_info.dart'
    as _i631;
import 'package:injectable/injectable.dart' as _i526;

class FrameworkBasePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    final deviceModule = _$DeviceModule();
    final gPSServiceModule = _$GPSServiceModule();
    final internetServiceModule = _$InternetServiceModule();
    final motionServiceModule = _$MotionServiceModule();
    final nFCServiceModule = _$NFCServiceModule();
    final authServiceModule = _$AuthServiceModule();
    final carSlopeServiceModule = _$CarSlopeServiceModule();
    gh.singleton<_i631.DeviceInfo>(() => deviceModule.provideDeviceInfo());
    gh.lazySingleton<_i373.GPSService>(
        () => gPSServiceModule.provideGPSService());
    gh.lazySingleton<_i23.InternetService>(
        () => internetServiceModule.provideInternetService());
    gh.lazySingleton<_i890.MotionService>(
        () => motionServiceModule.provideMotionService());
    gh.lazySingleton<_i927.NFCService>(
        () => nFCServiceModule.provideNFCService());
    gh.lazySingleton<_i708.AuthService>(
        () => authServiceModule.provideAuthService());
    gh.lazySingleton<_i1056.CarSlopeService>(
        () => carSlopeServiceModule.provideCarSlopeService(
              gh<_i373.GPSService>(),
              gh<_i890.MotionService>(),
            ));
  }
}

class _$DeviceModule extends _i631.DeviceModule {}

class _$GPSServiceModule extends _i373.GPSServiceModule {}

class _$InternetServiceModule extends _i23.InternetServiceModule {}

class _$MotionServiceModule extends _i890.MotionServiceModule {}

class _$NFCServiceModule extends _i927.NFCServiceModule {}

class _$AuthServiceModule extends _i708.AuthServiceModule {}

class _$CarSlopeServiceModule extends _i1056.CarSlopeServiceModule {}
