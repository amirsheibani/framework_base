import 'package:get_it/get_it.dart';
import 'di_setup.config.dart';
import 'package:injectable/injectable.dart';
import 'package:framework_base/di/framework_base_micro.module.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
  externalPackageModulesBefore: [
    ExternalModule(FrameworkBasePackageModule),
  ],
)
Future<void> configureDependencies() async {
  await $initGetIt(getIt);
}



