import 'package:flutter/widgets.dart';

import '../../../../framework_utils/lib/src/debounce_helper.dart';

class FormFieldState {
  dynamic value;
  dynamic expressionResult;
  List<String> errors;

  bool visible;
  bool enabled;

  TextEditingController? textController;
  late DebounceHelper debounceHelper;
  FormFieldState({
    this.value,
    this.expressionResult,
    this.errors = const [],
    this.visible = true,
    this.enabled = true,
  }){
    debounceHelper = DebounceHelper();
  }

  void dispose() {
    textController?.dispose();
    debounceHelper.dispose();
  }

  bool get isValid => errors.isEmpty;
}
