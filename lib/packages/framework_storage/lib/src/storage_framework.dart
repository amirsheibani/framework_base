import 'storage_framework_config.dart';
import 'unified_storage.dart';

class StorageFramework {
  final UnifiedStorage storage;

  StorageFramework._(this.storage);

  static Future<StorageFramework> init({
    required StorageFrameworkConfig config,
  }) async {
    final unified = config.build();
    await unified.init();
    return StorageFramework._(unified);
  }
}
