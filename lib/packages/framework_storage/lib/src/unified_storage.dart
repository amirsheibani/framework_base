import 'dart:convert';

import 'i_key_value_storage.dart';
import 'storage_key.dart';
import 'storage_target.dart';

class UnifiedStorage {
  final IKeyValueStorage local;
  final IKeyValueStorage secure;

  UnifiedStorage({
    required this.local,
    required this.secure,
  });

  Future<void> init() async {
    await local.init();
    await secure.init();
  }

  IKeyValueStorage _kv(StorageTarget target) {
    switch (target) {
      case StorageTarget.local:
        return local;
      case StorageTarget.secure:
        return secure;
    }
  }

  Future<void> setString(StorageKey key, String value) async {
    await _kv(key.target).setString(key.fullKey, value);
  }

  Future<String?> getString(StorageKey key) async {
    return _kv(key.target).getString(key.fullKey);
  }

  Future<void> setBool(StorageKey key, bool value) async {
    await _kv(key.target).setBool(key.fullKey, value);
  }

  Future<bool?> getBool(StorageKey key) async {
    return _kv(key.target).getBool(key.fullKey);
  }

  Future<void> setInt(StorageKey key, int value) async {
    await _kv(key.target).setInt(key.fullKey, value);
  }

  Future<int?> getInt(StorageKey key) async {
    return _kv(key.target).getInt(key.fullKey);
  }

  Future<void> setDouble(StorageKey key, double value) async {
    await _kv(key.target).setDouble(key.fullKey, value);
  }

  Future<double?> getDouble(StorageKey key) async {
    return _kv(key.target).getDouble(key.fullKey);
  }

  Future<void> remove(StorageKey key) async {
    await _kv(key.target).remove(key.fullKey);
  }

  Future<void> setJson(StorageKey key, Map<String, dynamic> json) async {
    final encoded = jsonEncode(json);
    await _kv(key.target).setString(key.fullKey, encoded);
  }

  Future<Map<String, dynamic>?> getJson(StorageKey key) async {
    final json = await _kv(key.target).getString(key.fullKey);
    if (json == null) return null;
    return jsonDecode(json) as Map<String, dynamic>;
  }
}
