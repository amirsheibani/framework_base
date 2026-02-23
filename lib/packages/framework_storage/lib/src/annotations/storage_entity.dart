import '../storage_target.dart';

class StorageEntity {
  final String? namespace;
  final StorageTarget target;
  final String idField;

  const StorageEntity({
    this.namespace,
    this.target = StorageTarget.local,
    this.idField = 'id',
  });
}
