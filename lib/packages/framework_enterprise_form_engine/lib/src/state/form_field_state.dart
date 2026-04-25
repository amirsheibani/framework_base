class FormFieldState {
  dynamic value;
  List<String> errors;

  bool visible;
  bool enabled;

  FormFieldState({
    this.value,
    this.errors = const [],
    this.visible = true,
    this.enabled = true,
  });

  bool get isValid => errors.isEmpty;
}
