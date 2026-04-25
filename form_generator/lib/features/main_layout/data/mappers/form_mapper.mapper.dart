// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'form_mapper.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

class FormMapperImpl extends FormMapper {
  @override
  FormEntity entityMapper(FormModel value) {
    return FormEntity(name: value.name, value: value.value);
  }

  @override
  FormModel modelMapper(FormEntity value) {
    return FormModel(name: value.name, value: value.value);
  }
}
