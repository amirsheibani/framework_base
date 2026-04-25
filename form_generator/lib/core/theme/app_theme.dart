import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_generator/generated/l10n.dart';
import 'package:framework_base/packages/framework_core/lib/core_framework.dart';


extension OnThemeType on ThemeType{
  get humanReadable{
    switch(this) {
      case ThemeType.dark:
        return S.current.dark;
      case ThemeType.light:
        return S.current.light;
      case ThemeType.system:
        return S.current.light;
    }
  }
}

extension OnAppTheme on ThemeData {


  ThemeData theme(String? languageCode) {
    return brightness == Brightness.light ? this : this;

  }

}
