import 'dart:convert';

import 'package:form_generator/core/di/base/di_setup.dart';
import 'package:form_generator/features/main_layout/data/data_sources/forms_data_source.dart';
import 'package:form_generator/features/main_layout/data/models/form_model.dart';
import 'package:framework_base/framework_base.dart';
import 'package:framework_base/packages/framework_core/lib/core_framework.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: FormsDataSource)
class FormsDataSourceImpl extends FormsDataSource {
  // final IpService _ipService;
  final UnifiedStorage _storage;
  FormsDataSourceImpl(this._storage);


  static const StorageKey _cacheKey = StorageKey(
    namespace: 'forms',
    key: 'last_forms',
    target: StorageTarget.secure,
  );

  @override
  Future<BaseListResponse<FormModel>> loadForms() async {
    final forms = await _storage.getString(_cacheKey);
    final List<Map<String, dynamic>> data = forms != null ? json.decode(forms) : [];
    final result = List<FormModel>.empty();
    for (var item in data) {
      result.add(FormModel.fromJson(item));
    }

    return BaseListResponse<FormModel>(data: result);

  }

  @override
  Future<BaseSingleResponse<bool>> saveForm(String name,FormModel form) async {
    final forms = await _storage.getString(_cacheKey);
    final List<Map<String, dynamic>> data = json.decode(forms!);
    final result = List<FormModel>.empty();
    for (var item in data) {
      result.add(FormModel.fromJson(item));
    }
    result.add(FormModel(name: name,value: json.encode(form.toJson())));
    await _storage.setString(_cacheKey, jsonEncode(result));
    return BaseSingleResponse(data: true);
  }

  @override
  Future<BaseSingleResponse<FormModel>> fetchForm(String name) async {
    final forms = await _storage.getString(_cacheKey);
    final List<Map<String, dynamic>> data = forms != null ? json.decode(forms) : [];
    final result = List<FormModel>.empty();
    for (var item in data) {
      result.add(FormModel.fromJson(item));
    }
    return BaseSingleResponse<FormModel>(data: result.firstWhereOrNull((item)=> item.name == name));
  }

}
