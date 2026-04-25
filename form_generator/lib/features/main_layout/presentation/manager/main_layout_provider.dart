import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_generator/core/di/base/di_setup.dart';
import 'package:form_generator/features/main_layout/presentation/manager/main_layout_notifier.dart';
import 'package:form_generator/features/main_layout/presentation/manager/main_layout_state.dart';

final mainLayoutProvider = StateNotifierProvider<MainLayoutNotifier, FormState>((ref) => getIt<MainLayoutNotifier>());