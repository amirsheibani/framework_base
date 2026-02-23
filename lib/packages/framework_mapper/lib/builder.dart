import 'package:build/build.dart';
import 'package:framework_base/packages/framework_mapper/lib/src/mapper_generator.dart';
import 'package:source_gen/source_gen.dart';


Builder mapperBuilder(BuilderOptions options) => PartBuilder([MapperGenerator()], '.mapper.dart');
