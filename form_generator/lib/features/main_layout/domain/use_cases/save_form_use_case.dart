import 'package:form_generator/features/main_layout/domain/entities/form_entity.dart';
import 'package:form_generator/features/main_layout/domain/repositories/forms_repository.dart';
import 'package:framework_base/packages/framework_core/lib/core_framework.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveFormUseCase extends BaseUseCaseNoArgs<Result<List<FormEntity>>> {
  final FormsRepository _repository;

  SaveFormUseCase(this._repository);

  @override
  Future<Result<List<FormEntity>>> call() async {
    final result = await _repository.loadForms();
    return result;
  }
}