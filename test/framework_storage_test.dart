import 'package:flutter_test/flutter_test.dart';
import 'package:framework_base/packages/framework_storage/lib/storage_framework.dart';

import 'framework_storage_test_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('framework_storage', () {
    group('ModelStorage - local (in-memory kv)', () {
      test('insert/get/update/delete maintains index and json', () async {
        final local = InMemoryKeyValueStorage();
        final secure = InMemoryKeyValueStorage();

        final storage = UnifiedStorage(local: local, secure: secure);
        await storage.init();

        final repo = ModelStorage<FrameworkStorageTestModel>(
          storage: storage,
          namespace: 't_local',
          target: StorageTarget.local,
          getId: (m) => m.id,
          toJson: (m) => m.toJson(),
          fromJson: (j) => FrameworkStorageTestModel.fromJson(j),
        );

        await repo.insert(FrameworkStorageTestModel(id: '1', name: 'a'));
        final r1 = await repo.getById('1');
        expect(r1?.name, 'a');

        await repo.update(FrameworkStorageTestModel(id: '1', name: 'b'));
        final r2 = await repo.getById('1');
        expect(r2?.name, 'b');

        final all = await repo.getAll();
        expect(all.length, 1);
        expect(all.first.id, '1');

        await repo.deleteById('1');
        expect(await repo.getById('1'), isNull);
        expect((await repo.getAll()).isEmpty, true);
      });
    });

    group('ModelStorage - secure (in-memory kv)', () {
      test('works same as local', () async {
        final local = InMemoryKeyValueStorage();
        final secure = InMemoryKeyValueStorage();

        final storage = UnifiedStorage(local: local, secure: secure);
        await storage.init();

        final repo = ModelStorage<FrameworkStorageTestModel>(
          storage: storage,
          namespace: 't_secure',
          target: StorageTarget.secure,
          getId: (m) => m.id,
          toJson: (m) => m.toJson(),
          fromJson: (j) => FrameworkStorageTestModel.fromJson(j),
        );

        await repo.insert(FrameworkStorageTestModel(id: '1', name: 'a'));
        expect((await repo.getAll()).length, 1);
        await repo.clear();
        expect((await repo.getAll()).isEmpty, true);
      });
    });
  });
}

class InMemoryKeyValueStorage implements IKeyValueStorage {
  final Map<String, Object?> _map = {};

  @override
  Future<void> init() async {}

  @override
  Future<bool?> getBool(String key) async => _map[key] as bool?;

  @override
  Future<double?> getDouble(String key) async => _map[key] as double?;

  @override
  Future<int?> getInt(String key) async => _map[key] as int?;

  @override
  Future<String?> getString(String key) async => _map[key] as String?;

  @override
  Future<void> setBool(String key, bool value) async {
    _map[key] = value;
  }

  @override
  Future<void> setDouble(String key, double value) async {
    _map[key] = value;
  }

  @override
  Future<void> setInt(String key, int value) async {
    _map[key] = value;
  }

  @override
  Future<void> setString(String key, String value) async {
    _map[key] = value;
  }

  @override
  Future<void> remove(String key) async {
    _map.remove(key);
  }

  @override
  Future<void> clear() async {
    _map.clear();
  }
}
