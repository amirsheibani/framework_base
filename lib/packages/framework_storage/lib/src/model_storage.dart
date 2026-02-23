import 'dart:convert';

import 'storage_key.dart';
import 'storage_target.dart';
import 'unified_storage.dart';

class ModelStorage<T> {
  final UnifiedStorage _storage;
  final String namespace;
  final StorageTarget target;
  final String Function(T model) getId;
  final Map<String, dynamic> Function(T model) toJson;
  final T Function(Map<String, dynamic> json) fromJson;

  ModelStorage({
    required UnifiedStorage storage,
    required this.namespace,
    required this.target,
    required this.getId,
    required this.toJson,
    required this.fromJson,
  }) : _storage = storage;

  StorageKey _itemKey(String id) => StorageKey(namespace: namespace, key: 'item:$id', target: target);
  StorageKey _indexKey() => StorageKey(namespace: namespace, key: 'index', target: target);

  Future<void> insert(T model) async {
    final id = getId(model);
    await _setItem(id, model);
    await _addToIndex(id);
  }

  Future<void> update(T model) async {
    final id = getId(model);
    await _setItem(id, model);
    await _addToIndex(id);
  }

  Future<void> deleteById(String id) async {
    await _storage.remove(_itemKey(id));
    await _removeFromIndex(id);
  }

  Future<T?> getById(String id) async {
    final json = await _storage.getJson(_itemKey(id));
    if (json == null) return null;
    return fromJson(json);
  }

  Future<List<T>> getAll() async {
    final ids = await _getIndexIds();
    final result = <T>[];
    for (final id in ids) {
      final item = await getById(id);
      if (item != null) result.add(item);
    }
    return result;
  }

  Future<void> clear() async {
    final ids = await _getIndexIds();
    for (final id in ids) {
      await _storage.remove(_itemKey(id));
    }
    await _storage.remove(_indexKey());
  }

  Future<void> _setItem(String id, T model) async {
    await _storage.setJson(
      _itemKey(id),
      toJson(model),
    );
  }

  Future<List<String>> _getIndexIds() async {
    final json = await _storage.getString(_indexKey());
    if (json == null || json.isEmpty) return const <String>[];
    final decoded = jsonDecode(json);
    if (decoded is! List) return const <String>[];
    return decoded.map((e) => e.toString()).toList(growable: false);
  }

  Future<void> _setIndexIds(List<String> ids) async {
    await _storage.setString(_indexKey(), jsonEncode(ids));
  }

  Future<void> _addToIndex(String id) async {
    final ids = (await _getIndexIds()).toList(growable: true);
    if (!ids.contains(id)) ids.add(id);
    await _setIndexIds(ids);
  }

  Future<void> _removeFromIndex(String id) async {
    final ids = (await _getIndexIds()).where((e) => e != id).toList(growable: false);
    await _setIndexIds(ids);
  }
}
