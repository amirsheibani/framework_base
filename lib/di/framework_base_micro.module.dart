//@GeneratedMicroModule;FrameworkBasePackageModule;package:framework_base/di/framework_base_micro.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:framework_base/packages/framework_service/lib/src/car_slope_service.dart'
    as _i613;
import 'package:framework_base/packages/framework_service/lib/src/gps_service_handler.dart'
    as _i332;
import 'package:framework_base/packages/framework_service/lib/src/internet_service/internet_service.dart'
    as _i1044;
import 'package:framework_base/packages/framework_service/lib/src/motion_service_handler.dart'
    as _i1033;
import 'package:framework_base/packages/framework_service/lib/src/nfc_service_handler.dart'
    as _i1068;
import 'package:framework_base/packages/framework_service/lib/src/supabase_auth_service_handler.dart'
    as _i471;
import 'package:framework_base/packages/framework_storage/lib/src/adapters/secure_kv_storage.dart'
    as _i723;
import 'package:framework_base/packages/framework_storage/lib/src/adapters/shared_preferences_kv_storage.dart'
    as _i129;
import 'package:framework_base/packages/framework_storage/lib/src/di/storage_module.dart'
    as _i398;
import 'package:framework_base/packages/framework_storage/lib/src/unified_storage.dart'
    as _i892;
import 'package:framework_base/packages/framework_utils/lib/src/device_info.dart'
    as _i631;
import 'package:injectable/injectable.dart' as _i526;

class FrameworkBasePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) async {
    final deviceModule = _$DeviceModule();
    final gPSServiceModule = _$GPSServiceModule();
    final internetServiceModule = _$InternetServiceModule();
    final motionServiceModule = _$MotionServiceModule();
    final nFCServiceModule = _$NFCServiceModule();
    final authServiceModule = _$AuthServiceModule();
    final frameworkStorageModule = _$FrameworkStorageModule();
    final carSlopeServiceModule = _$CarSlopeServiceModule();
    gh.singleton<_i631.DeviceInfo>(() => deviceModule.provideDeviceInfo());
    gh.lazySingleton<_i332.GPSService>(
        () => gPSServiceModule.provideGPSService());
    gh.lazySingleton<_i1044.InternetService>(
        () => internetServiceModule.provideInternetService());
    gh.lazySingleton<_i1033.MotionService>(
        () => motionServiceModule.provideMotionService());
    gh.lazySingleton<_i1068.NFCService>(
        () => nFCServiceModule.provideNFCService());
    gh.lazySingleton<_i471.AuthService>(
        () => authServiceModule.provideAuthService());
    gh.lazySingleton<_i129.SharedPreferencesKeyValueStorage>(
        () => frameworkStorageModule.provideLocalStorage());
    gh.lazySingleton<_i723.SecureKeyValueStorage>(
        () => frameworkStorageModule.provideSecureStorage());
    await gh.factoryAsync<_i892.UnifiedStorage>(
      () => frameworkStorageModule.provideUnifiedStorage(
        gh<_i129.SharedPreferencesKeyValueStorage>(),
        gh<_i723.SecureKeyValueStorage>(),
      ),
      preResolve: true,
    );
    gh.lazySingleton<_i613.CarSlopeService>(
        () => carSlopeServiceModule.provideCarSlopeService(
              gh<_i332.GPSService>(),
              gh<_i1033.MotionService>(),
            ));
  }
}

class _$DeviceModule extends _i631.DeviceModule {}

class _$GPSServiceModule extends _i332.GPSServiceModule {}

class _$InternetServiceModule extends _i1044.InternetServiceModule {}

class _$MotionServiceModule extends _i1033.MotionServiceModule {}

class _$NFCServiceModule extends _i1068.NFCServiceModule {}

class _$AuthServiceModule extends _i471.AuthServiceModule {}

class _$FrameworkStorageModule extends _i398.FrameworkStorageModule {}

class _$CarSlopeServiceModule extends _i613.CarSlopeServiceModule {}
