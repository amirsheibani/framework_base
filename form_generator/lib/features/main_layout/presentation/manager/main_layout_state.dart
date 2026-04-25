
import 'package:form_generator/features/main_layout/domain/entities/form_entity.dart';

base class FormState {
  const FormState();
}

final class FormStateInit extends FormState {
  const FormStateInit();
}

final class FormStateLoading extends FormState {
  const FormStateLoading();
}

final class FormStateSuccess extends FormState {
  final List<FormEntity> data;

  const FormStateSuccess({
    required this.data,
  });
}

final class FormStateFailed extends FormState {
  final String message;
  const FormStateFailed({required this.message});
}