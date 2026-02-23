import 'package:injectable/injectable.dart';

import '../adapters/secure_kv_storage.dart';
import '../adapters/shared_preferences_kv_storage.dart';
import '../unified_storage.dart';

@module
abstract class FrameworkStorageModule {
  @lazySingleton
  SharedPreferencesKeyValueStorage provideLocalStorage() => SharedPreferencesKeyValueStorage();

  @lazySingleton
  SecureKeyValueStorage provideSecureStorage() => SecureKeyValueStorage();

  @preResolve
  Future<UnifiedStorage> provideUnifiedStorage(
    SharedPreferencesKeyValueStorage local,
    SecureKeyValueStorage secure,
  ) async {
    final storage = UnifiedStorage(local: local, secure: secure);
    await storage.init();
    return storage;
  }
}
