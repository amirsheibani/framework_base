// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:framework_base/di/framework_base_micro.module.dart' as _i121;
import 'package:framework_base/framework_base.dart' as _i156;
import 'package:framework_base/packages/framework_utils/lib/utils_framework.dart'
    as _i131;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../../features/main_layout/data/data_sources/forms_data_source.dart'
    as _i493;
import '../../../features/main_layout/data/data_sources/forms_data_source_impl.dart'
    as _i559;
import '../../../features/main_layout/data/repositories/forms_repository_impl.dart'
    as _i990;
import '../../../features/main_layout/domain/repositories/forms_repository.dart'
    as _i16;
import '../../../features/main_layout/domain/use_cases/fetch_form_use_case.dart'
    as _i342;
import '../../../features/main_layout/domain/use_cases/load_forms_use_case.dart'
    as _i533;
import '../../../features/main_layout/domain/use_cases/save_form_use_case.dart'
    as _i943;
import '../../../features/main_layout/presentation/manager/main_layout_notifier.dart'
    as _i872;
import '../remote/remote_module.dart' as _i707;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  await _i121.FrameworkBasePackageModule().init(gh);
  final remoteModule = _$RemoteModule();
  gh.singleton<_i131.CustomPrettyLogger>(() => remoteModule.prettyDioLogger);
  gh.singleton<_i361.Dio>(() => remoteModule.dio);
  gh.lazySingleton<_i361.Dio>(
    () => remoteModule.dioUpload,
    instanceName: 'uploadFile',
  );
  gh.lazySingleton<_i361.Dio>(
    () => remoteModule.dioDownload,
    instanceName: 'downloadFile',
  );
  gh.factory<_i493.FormsDataSource>(
    () => _i559.FormsDataSourceImpl(gh<_i156.UnifiedStorage>()),
  );
  gh.factory<_i16.FormsRepository>(
    () => _i990.FormsRepositoryImpl(gh<_i493.FormsDataSource>()),
  );
  gh.factory<_i342.FetchFormUseCase>(
    () => _i342.FetchFormUseCase(gh<_i16.FormsRepository>()),
  );
  gh.factory<_i533.LoadFormsUseCase>(
    () => _i533.LoadFormsUseCase(gh<_i16.FormsRepository>()),
  );
  gh.factory<_i943.SaveFormUseCase>(
    () => _i943.SaveFormUseCase(gh<_i16.FormsRepository>()),
  );
  gh.factory<_i872.MainLayoutNotifier>(
    () => _i872.MainLayoutNotifier(
      gh<_i533.LoadFormsUseCase>(),
      gh<_i943.SaveFormUseCase>(),
      gh<_i342.FetchFormUseCase>(),
    ),
  );
  return getIt;
}

class _$RemoteModule extends _i707.RemoteModule {}
