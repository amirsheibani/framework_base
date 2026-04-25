import 'package:form_generator/features/main_layout/domain/entities/form_entity.dart';
import 'package:framework_base/framework_base.dart';
import 'package:framework_base/packages/framework_core/lib/core_framework.dart';

abstract class FormsRepository {
  Future<Result<List<FormEntity>>> loadForms();
  Future<Result<FormEntity>> fetchForm(String name);
  Future<Result<bool>> saveForm(String name ,FormEntity form);
}
