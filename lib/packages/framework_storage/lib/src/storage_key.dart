import 'storage_target.dart';

class StorageKey {
  final String namespace;
  final String key;
  final StorageTarget target;

  const StorageKey({
    required this.namespace,
    required this.key,
    required this.target,
  });

  String get fullKey => '$namespace:$key';
}
