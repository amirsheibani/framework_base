import 'package:form_generator/features/main_layout/data/models/form_model.dart';
import 'package:form_generator/features/main_layout/domain/entities/form_entity.dart';
import 'package:framework_base/framework_base.dart';
part 'form_mapper.mapper.dart';

@Mapper()
abstract class FormMapper{

  FormEntity entityMapper(FormModel value);

  FormModel modelMapper(FormEntity value);
}
