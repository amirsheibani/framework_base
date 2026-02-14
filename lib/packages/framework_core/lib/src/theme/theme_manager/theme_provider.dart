import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:framework_base/packages/framework_core/lib/src/theme/theme_manager/theme_notifier.dart';
import 'package:framework_base/packages/framework_core/lib/src/theme/theme_manager/theme_state.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) => ThemeNotifier());
