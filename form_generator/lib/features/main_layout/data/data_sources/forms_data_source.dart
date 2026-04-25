
import 'package:form_generator/features/main_layout/data/models/form_model.dart';
import 'package:framework_base/framework_base.dart';
import 'package:framework_base/packages/framework_core/lib/core_framework.dart';


abstract class FormsDataSource {

  Future<BaseListResponse<FormModel>> loadForms();
  Future<BaseSingleResponse<bool>> saveForm(String name ,FormModel form);
  Future<BaseSingleResponse<FormModel>> fetchForm(String name);
}
