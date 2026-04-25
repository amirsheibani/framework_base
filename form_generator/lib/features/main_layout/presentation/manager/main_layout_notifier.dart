import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_generator/features/main_layout/domain/entities/form_entity.dart';
import 'package:form_generator/features/main_layout/domain/use_cases/fetch_form_use_case.dart';
import 'package:form_generator/features/main_layout/domain/use_cases/load_forms_use_case.dart';
import 'package:form_generator/features/main_layout/domain/use_cases/save_form_use_case.dart';
import 'package:form_generator/features/main_layout/presentation/manager/main_layout_state.dart';
import 'package:framework_base/packages/framework_core/lib/src/base/result.dart';
import 'package:injectable/injectable.dart';

@injectable
class MainLayoutNotifier extends StateNotifier<FormState> {

  final LoadFormsUseCase _loadFormsUseCase;
  final SaveFormUseCase _saveFormUseCase;
  final FetchFormUseCase _fetchFormUseCase;
  MainLayoutNotifier(this._loadFormsUseCase,this._saveFormUseCase,this._fetchFormUseCase) : super(FormStateInit());

  Future<void> init() async {
    state = FormStateLoading();
    final result = await _loadFormsUseCase.call();
    switch(result){
      case Success<List<FormEntity>>():
        if(result.data != null){
          state = FormStateSuccess(data: result.data!);
        }else{
          state = FormStateFailed(message: 'data is null');
        }
      case Failure():
        state = FormStateFailed(message: result.message);
    }
  }

  Future<void> save() async {
    state = FormStateLoading();
    final result = await _saveFormUseCase.call();
    switch(result){
      case Success<List<FormEntity>>():
        if(result.data != null){
          state = FormStateSuccess(data: result.data!);
        }else{
          state = FormStateFailed(message: 'data is null');
        }
      case Failure():
        state = FormStateFailed(message: result.message);
    }
  }
}

