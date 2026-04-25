
import 'package:framework_base/framework_base.dart';

import 'form_layout.dart';

mixin FormHandler {
  FormWidget? createChild(Map<String, dynamic>? json){
    if(json != null){
      switch(json['name']){
        case 'FormLayout':
          return FormLayout().fromJson(json);
        default:
          return null;
      }
    }else{
      return null;
    }
  }
}