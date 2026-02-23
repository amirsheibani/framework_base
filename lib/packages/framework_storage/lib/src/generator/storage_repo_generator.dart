import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../annotations/storage_entity.dart';

class StorageRepoGenerator extends GeneratorForAnnotation<StorageEntity> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '@StorageEntity can only be used on classes.',
        element: element,
      );
    }

    final className = element.name;
    final namespace = annotation.peek('namespace')?.stringValue ?? className;
    final targetIndex = annotation.peek('target')?.objectValue.getField('index')?.toIntValue() ?? 0;
    final idField = annotation.peek('idField')?.stringValue ?? 'id';

    final repoName = '${className}StorageRepo';
    final out = StringBuffer();

    out.writeln('class $repoName {');
    out.writeln('  final ModelStorage<$className> _storage;');
    out.writeln('');
    out.writeln('  $repoName(UnifiedStorage storage)');
    out.writeln('      : _storage = ModelStorage<$className>(');
    out.writeln('          storage: storage,');
    out.writeln("          namespace: '$namespace',");
    out.writeln('          target: StorageTarget.values[$targetIndex],');
    out.writeln('          getId: (m) => m.$idField.toString(),');
    out.writeln('          toJson: (m) => m.toJson(),');
    out.writeln('          fromJson: (j) => $className.fromJson(j),');
    out.writeln('        );');
    out.writeln('');

    out.writeln('  Future<void> insert($className model) => _storage.insert(model);');
    out.writeln('  Future<void> update($className model) => _storage.update(model);');
    out.writeln('  Future<void> deleteById(String id) => _storage.deleteById(id);');
    out.writeln('  Future<$className?> getById(String id) => _storage.getById(id);');
    out.writeln('  Future<List<$className>> getAll() => _storage.getAll();');
    out.writeln('  Future<void> clear() => _storage.clear();');

    out.writeln('}');

    return out.toString();
  }
}
