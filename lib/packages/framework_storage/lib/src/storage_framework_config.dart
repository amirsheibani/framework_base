import 'adapters/secure_kv_storage.dart';
import 'adapters/shared_preferences_kv_storage.dart';
import 'unified_storage.dart';

class StorageFrameworkConfig {
  final SharedPreferencesKeyValueStorage local;
  final SecureKeyValueStorage secure;

  StorageFrameworkConfig({
    required this.local,
    required this.secure,
  });

  UnifiedStorage build() {
    return UnifiedStorage(local: local, secure: secure);
  }
}
