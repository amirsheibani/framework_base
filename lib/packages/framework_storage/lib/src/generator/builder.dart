import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'storage_repo_generator.dart';

Builder storageRepoBuilder(BuilderOptions options) {
  return SharedPartBuilder([StorageRepoGenerator()], 'storage_repo');
}
