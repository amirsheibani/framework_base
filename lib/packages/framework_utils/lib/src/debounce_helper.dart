import 'dart:async';
import 'package:flutter/foundation.dart';

/// Helper class برای debouncing callback‌ها
/// استفاده:
/// final debounce = DebounceHelper(duration: Duration(milliseconds: 500));
/// debounce(() {
///   // کد شما
/// });
class DebounceHelper {
  Timer? _timer;
  final Duration duration;

  DebounceHelper({
    this.duration = const Duration(milliseconds: 500),
  });

  /// فراخوانی callback با debounce
  void call(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(duration, callback);
  }

  /// لغو debounce در حال انتظار
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// پاک‌کردن منابع
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }

  /// بررسی اینکه آیا debounce فعال است
  bool get isActive => _timer?.isActive ?? false;
}