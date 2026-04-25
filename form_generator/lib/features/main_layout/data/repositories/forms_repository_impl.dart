import 'package:form_generator/features/main_layout/data/data_sources/forms_data_source.dart';
import 'package:form_generator/features/main_layout/data/mappers/form_mapper.dart';
import 'package:form_generator/features/main_layout/domain/entities/form_entity.dart';
import 'package:form_generator/features/main_layout/domain/repositories/forms_repository.dart';
import 'package:framework_base/framework_base.dart';
import 'package:framework_base/packages/framework_core/lib/core_framework.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FormsRepository)
class FormsRepositoryImpl extends FormsRepository {
  final FormsDataSource _dataSource;

  FormsRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<FormEntity>>> loadForms() async {
    try {
      final result = await _dataSource.loadForms();
      return Success(data: result.data?.map((item) => FormMapperImpl().entityMapper(item)).toList(), message: result.message);
    } catch (e, stackTrace) {
      return e.toResult<List<FormEntity>>(stackTrace);
    }
  }

  @override
  Future<Result<bool>> saveForm(String name ,FormEntity form) async {
    try {
      final result = await _dataSource.saveForm(name, FormMapperImpl().modelMapper(form));
      return Success(data: result.data, message: result.message);
    } catch (e, stackTrace) {
      return e.toResult<bool>(stackTrace);
    }
  }

  @override
  Future<Result<FormEntity>> fetchForm(String name) async {
    try {
      final result = await _dataSource.fetchForm(name);
      return Success(data:result.data != null ? FormMapperImpl().entityMapper(result.data!) : null, message: result.message);
    } catch (e, stackTrace) {
      return e.toResult<FormEntity>(stackTrace);
    }
  }
}
