import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../i_key_value_storage.dart';

class SecureKeyValueStorage implements IKeyValueStorage {
  final FlutterSecureStorage _storage;

  SecureKeyValueStorage({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  @override
  Future<void> init() async {}

  @override
  Future<String?> getString(String key) => _storage.read(key: key);

  @override
  Future<void> setString(String key, String value) => _storage.write(key: key, value: value);

  @override
  Future<bool?> getBool(String key) async {
    final v = await getString(key);
    if (v == null) return null;
    return v == 'true';
  }

  @override
  Future<void> setBool(String key, bool value) => setString(key, value.toString());

  @override
  Future<int?> getInt(String key) async {
    final v = await getString(key);
    if (v == null) return null;
    return int.tryParse(v);
  }

  @override
  Future<void> setInt(String key, int value) => setString(key, value.toString());

  @override
  Future<double?> getDouble(String key) async {
    final v = await getString(key);
    if (v == null) return null;
    return double.tryParse(v);
  }

  @override
  Future<void> setDouble(String key, double value) => setString(key, value.toString());

  @override
  Future<void> remove(String key) => _storage.delete(key: key);

  @override
  Future<void> clear() => _storage.deleteAll();
}
