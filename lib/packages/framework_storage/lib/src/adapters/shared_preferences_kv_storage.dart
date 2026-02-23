import 'package:shared_preferences/shared_preferences.dart';

import '../i_key_value_storage.dart';

class SharedPreferencesKeyValueStorage implements IKeyValueStorage {
  SharedPreferences? _prefs;

  @override
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  SharedPreferences get _p {
    final prefs = _prefs;
    if (prefs == null) {
      throw StateError('SharedPreferencesKeyValueStorage not initialized. Call init() first.');
    }
    return prefs;
  }

  @override
  Future<bool?> getBool(String key) async => _p.getBool(key);

  @override
  Future<double?> getDouble(String key) async => _p.getDouble(key);

  @override
  Future<int?> getInt(String key) async => _p.getInt(key);

  @override
  Future<String?> getString(String key) async => _p.getString(key);

  @override
  Future<void> setBool(String key, bool value) async {
    await _p.setBool(key, value);
  }

  @override
  Future<void> setDouble(String key, double value) async {
    await _p.setDouble(key, value);
  }

  @override
  Future<void> setInt(String key, int value) async {
    await _p.setInt(key, value);
  }

  @override
  Future<void> setString(String key, String value) async {
    await _p.setString(key, value);
  }

  @override
  Future<void> remove(String key) async {
    await _p.remove(key);
  }

  @override
  Future<void> clear() async {
    await _p.clear();
  }
}
