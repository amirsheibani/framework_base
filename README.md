# Framework Base

یک پکیج پایه Flutter برای ساخت اپلیکیشن‌های حرفه‌ای با معماری تمیز، مدیریت تم، سرویس‌های مشترک و اکستنشن‌های کاربردی.

A base Flutter package for building production apps with clean architecture, theme management, shared services, and utility extensions.

---

## ویژگی‌ها (Features)

- **Core**: محیط (Environment)، الگوی Result، Use Caseها، پاسخ‌های API، صفحه‌بندی، تم و ویجت‌های پایه
- **Utils**: اکستنشن‌های String، Int، DateTime، Context، تاریخ شمسی (Jalali)، جستجو با Debounce، Device Info و لاگر
- **Handlers**: سرویس‌های اینترنت، GPS، NFC، سنسور حرکت، شیب خودرو، احراز هویت Supabase و اعلان‌ها

وابستگی‌های کلیدی: Flutter Riverpod، Injectable، Retrofit، Supabase، Geolocator، NFC Manager، Sensors و غیره.

---

## نصب (Getting started)

### وابستگی (Dependency)

در `pubspec.yaml` پروژه‌ی Flutter خود اضافه کنید:

**از مسیر محلی:**

```yaml
dependencies:
  framework_base:
    path: ../path/to/framework_base
```

**از Git:**

```yaml
dependencies:
  framework_base:
    git:
      url: https://github.com/your-org/framework_base.git
      ref: main
```

سپس:

```bash
flutter pub get
```

### پیش‌نیازها

- Flutter SDK `>=1.17.0`
- Dart SDK `^3.10.4`

---

## استفاده (Usage)

### ایمپورت یک‌جا

```dart
import 'package:framework_base/framework_base.dart';
```

### ایمپورت جداگانه ماژول‌ها

```dart
// هسته: Environment، Result، UseCase، تم، ویجت‌ها
import 'package:framework_base/packages/framework_core/lib/core_framework.dart';

// یوتیلیتی‌ها: اکستنشن‌ها، Device Info، لاگر
import 'package:framework_base/packages/framework_utils/lib/utils_framework.dart';

// سرویس‌ها: اینترنت، GPS، NFC، Motion، Supabase Auth و ...
import 'package:framework_base/packages/framework_handler/lib/handler_framework.dart';
```

---

## ماژول‌ها (Modules)

### 1. Framework Core (`core_framework`)

| بخش | توضیح |
|-----|--------|
| **Environment** | `Environment`, `DevEnvironment`, `StageEnvironment`, `ProdEnvironment` — تنظیمات baseUrl، apiVersion، mapToken، appId، Supabase، لاگ و Chucker |
| **Result** | `Result<T>`, `Success<T>`, `Failure<T>` برای هندلینگ یکپارچه موفقیت/خطا |
| **Use Cases** | `BaseUseCase<R,P>`, `BaseUseCaseNoArgs<R>`, `BaseUseCaseWithPagination`, `BaseStreamUseCase` و انواع بدون آرگومان |
| **Response** | `BaseResponse`, `BaseListResponse<T>`, `BaseSingleResponse<T>`, `BaseListResponseWithPages` برای API با Retrofit |
| **Pagination** | کلاس `Pagination` با فیلدهای page، pageSize، total و متد `toQueryParameters()` |
| **Theme** | `BaseTheme`, `ThemeType`, `PalletColor`, `ThemeNotifier`, `ThemeProvider`, `ThemeState` |
| **Widgets** | `AppBlurOverlay`, `DismissibleKeyboard` |
| **Extensions** | `Result` extension، `NetworkExceptions` |

### 2. Framework Utils (`utils_framework`)

| بخش | توضیح |
|-----|--------|
| **Extensions** | `ContextExtension`, `StringExtension`, `IntExtension`, `DateTimeExtension`, `JalaliExtension`, `SearchDebounceExtension` |
| **Device** | `DeviceInfo` برای اطلاعات دستگاه |
| **Logger** | `CustomPrettyLogger` برای لاگ خواناتر |

### 3. Framework Handler (`handler_framework`)

| سرویس | توضیح |
|--------|--------|
| **InternetService** | وضعیت اتصال (Connectivity + واقعی با `InternetConnectionChecker`)، استریم تغییرات |
| **GpsService** | موقعیت مکانی (Geolocator) |
| **NfcService** | کار با NFC |
| **MotionService** | سنسورهای حرکت (sensors_plus) |
| **CarSlopeService** | محاسبه شیب خودرو |
| **AuthService** | ثبت‌نام، ورود، خروج و مدیریت سشن با Supabase |
| **NotificationService** | اعلان‌ها |

سرویس‌ها با **Injectable** ماژول شده‌اند (`@module`, `@lazySingleton`) و در صورت استفاده از DI در اپ، ماژول‌ها را ثبت کنید.

---

## مثال‌های کوتاه

### Environment

```dart
final env = DevEnvironment(
  baseUrl: 'https://api.example.com',
  apiVersion: 'v1',
  mapToken: 'your_map_token',
  appId: 'your_app_id',
  showRuntimeLog: true,
  showChucker: true,
  showPrettyLog: true,
  supabaseUrl: 'https://xxx.supabase.co',
  supabaseAnonKey: 'your_anon_key',
);
```

### Result و UseCase

```dart
// استفاده از Result (sealed class: Success / Failure)
Result<User> result = await someUseCase(params);
switch (result) {
  case Success(data: final user, message: _, meta: _):
    // استفاده از user
  case Failure(message: final msg, meta: _):
    // نمایش خطا
}

// تعریف UseCase
class GetUserUseCase implements BaseUseCase<User, String> {
  @override
  Future<Result<User>> call(String userId) async { ... }
}
```

### تم (Theme)

با `ThemeNotifier` و `ThemeProvider` (Riverpod) می‌توانید تم روشن/تاریک/سیستم را مدیریت کنید.

### سرویس اینترنت

```dart
// با Injectable
final internetService = getIt<InternetService>();
internetService.internetStatus.listen((isConnected, connectivityResult) {
  // به‌روزرسانی UI
});
```

---

## ساختار پروژه

```
lib/
  framework_base.dart          # export یک‌جای همه ماژول‌ها
  packages/
    framework_core/lib/        # هسته
    framework_utils/lib/       # یوتیلیتی‌ها
    framework_handler/lib/     # سرویس‌ها
```

---

## تست

```bash
flutter test
```

---

## مجوز (License)

مطابق فایل [LICENSE](LICENSE) این پروژه منتشر شده است.
