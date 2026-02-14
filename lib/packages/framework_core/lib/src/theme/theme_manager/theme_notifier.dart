import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:framework_base/packages/framework_core/lib/src/theme/theme_manager/theme_state.dart';

import '../base_theme.dart';

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(const ThemeState(ThemeType.system));

  void setLight() => state = const ThemeState(ThemeType.light);
  void setDark() => state = const ThemeState(ThemeType.dark);
  void setSystem() => state = const ThemeState(ThemeType.system);
}
