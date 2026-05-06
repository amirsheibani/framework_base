# ✨ Refresh Token Feature - تغییرات شامل

## 📅 تاریخ افزودن: 28 تیر 1403 (2024-04-28)

---

## 🎯 مقصد این ویژگی

کاربران می‌توانند توکن JWT خود را **بدون ورود مجدد** رفرش کنند تا سشنی‌ای طولانی‌مدت داشته باشند.

---

## 📁 فایل‌های ایجاد شده / بروزرسانی شده

### ✅ فایل‌های جدید

#### 1. `RefreshTokenRequest.java`
```
📍 Location: dto/auth/
📝 نقش: DTO برای درخواست رفرش
📚 حاوی: فیلد token (توکن قدیم)
```

#### 2. `REFRESH_TOKEN_GUIDE_FA.md`
```
📍 Location: Root
📝 نقش: راهنمای کامل و جامع
📚 حاوی: 
  • نحوه کار refresh token
  • مثال‌های عملی
  • بهترین روش‌ها
  • سناریوهای مختلف
```

#### 3. `REFRESH_TOKEN_QUICK_GUIDE_FA.md`
```
📍 Location: Root
📝 نقش: خلاصه سریع برای شروع سریع
📚 حاوی:
  • مثال‌های کوتاه
  • نقاط مهم
  • استراتژی رفرش خودکار
```

---

### 🔄 فایل‌های بروزرسانی شده

#### 1. `AuthService.java`
```diff
+ import RefreshTokenRequest;

+ public AuthResponse refreshToken(RefreshTokenRequest request) {
+     // بررسی توکن
+     // استخراج ایمیل
+     // تولید توکن جدید
+     return new AuthResponse(newToken);
+ }
```

**تغییرات:**
- اضافه کردن method `refreshToken()`
- کامنت‌های فارسی تفصیلی (20 خط)
- Exception handling برای توکن‌های نامعتبر

---

#### 2. `AuthController.java`
```diff
+ import RefreshTokenRequest;

+ @PostMapping("/refresh")
+ public AuthResponse refresh(@RequestBody RefreshTokenRequest request) {
+     return authService.refreshToken(request);
+ }
```

**تغییرات:**
- اضافه کردن endpoint `POST /api/auth/refresh`
- کامنت‌های جامع برای استفاده (20 خط)
- مثال‌های cURL در javadoc

---

#### 3. `JwtService.java`
```diff
  public String extractEmail(String token) {
      try {
          return Jwts.parserBuilder()...
+     } catch (ExpiredJwtException e) {
+         // حتی برای توکن‌های منقضی‌شده
+         return e.getClaims().getSubject();
+     }
  }
```

**تغییرات:**
- بهبود method `extractEmail()`
- اضافه کردن exception handling برای ExpiredJwtException
- اجازه استخراج ایمیل از توکن‌های منقضی‌شده

---

#### 4. `SecurityConfig.java`
```diff
  .requestMatchers(
      "/api/auth/**",
      ...
  ).permitAll()
```

**تغییرات:**
- endpoint `/api/auth/refresh` به‌صورت خودکار عمومی است
- نیاز دسترسی عمومی (احراز هویت ندارد)

---

## 📊 خلاصه تغییرات

| موضوع | تعداد | توضیح |
|-------|-------|---------|
| فایل‌های جدید | 3 | RefreshTokenRequest + 2 guide |
| فایل‌های بروزرسانی | 4 | AuthService, AuthController, JwtService, SecurityConfig |
| Endpoints جدید | 1 | POST /api/auth/refresh |
| Methods جدید | 1 | refreshToken() در AuthService |
| خطوط کامنت اضافه | 40+ | توضیحات فارسی |

---

## 🔄 Flow دقیق Refresh Token

```
┌─────────────────────────────────────────────┐
│  1. کاربر درخواست رفرش می‌فرستد           │
│     POST /api/auth/refresh                  │
│     { "token": "OLD_JWT_TOKEN" }           │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│  2. AuthController::refresh()               │
│     authService.refreshToken(request) فراخوانی
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│  3. AuthService::refreshToken()             │
│     • بررسی توکن خالی نیست                │
│     • استخراج ایمیل از توکن                │
│     • تولید توکن جدید                      │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│  4. JwtService::extractEmail()              │
│     • Parse توکن                           │
│     • اگر expired بود:                      │
│       → استخراج ایمیل از claims            │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│  5. JwtService::generateToken()             │
│     • ایجاد token جدید                     │
│     • 24 ساعت معتبر                        │
│     • امضای درست                          │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│  6. پاسخ به کاربر                           │
│     { "token": "NEW_JWT_TOKEN" }           │
│     Status: 200 OK                          │
└─────────────────────────────────────────────┘
```

---

## 🧪 تست دستی

### Test 1: رفرش توکن معتبر

```bash
# 1. ورود
curl -X POST http://localhost:8081/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"123"}'
  
# 2. توکن را کپی کنید
# 3. رفرش کنید
curl -X POST http://localhost:8081/api/auth/refresh \
  -H "Content-Type: application/json" \
  -d '{"token":"YOUR_TOKEN_HERE"}'

# ✅ نتیجه: توکن جدید دریافت کنید
```

### Test 2: رفرش توکن منقضی‌شده

```bash
# حتی اگر توکن 24 ساعت منقضی باشد
# باز هم می‌توانید رفرش کنید!

curl -X POST http://localhost:8081/api/auth/refresh \
  -H "Content-Type: application/json" \
  -d '{"token":"EXPIRED_TOKEN"}'

# ✅ نتیجه: توکن جدید معتبر 24 ساعت
```

---

## 🎓 نمونه کد - استفاده در Front-End

### React Hook

```javascript
// useAuthRefresh.js
import { useEffect } from 'react';

export function useAuthRefresh() {
  useEffect(() => {
    // رفرش هر 12 ساعت
    const interval = setInterval(async () => {
      const token = localStorage.getItem('authToken');
      
      if (token) {
        try {
          const res = await fetch('/api/auth/refresh', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ token })
          });
          
          const { token: newToken } = await res.json();
          localStorage.setItem('authToken', newToken);
          
        } catch (error) {
          console.error('Token refresh failed:', error);
        }
      }
    }, 12 * 60 * 60 * 1000);
    
    return () => clearInterval(interval);
  }, []);
}

// استفاده در App
function App() {
  useAuthRefresh();
  return <div>Your App</div>;
}
```

---

## ⚠️ نکات امنیتی

### 1️⃣ توکن را در جای ایمن نگه‌دارید
```javascript
// ✅ خوب: sessionStorage یا memory
sessionStorage.setItem('authToken', token);

// ❌ بد: localStorage (اگر XSS باشد)
localStorage.setItem('authToken', token);
```

### 2️⃣ از HTTPS استفاده کنید
```
❌ http://localhost:8081/api/auth/refresh
✅ https://yourdomain.com/api/auth/refresh
```

### 3️⃣ توکن را ارسال کنید
```javascript
// ✅ خوب: در body (برای refresh)
fetch('/api/auth/refresh', {
  body: JSON.stringify({ token })
})

// ✅ خوب: در header (برای سایر endpoints)
fetch('/api/projects', {
  headers: { 'Authorization': 'Bearer ' + token }
})
```

---

## 📈 بهبودی‌های آتی

- [ ] Refresh Token Rotation (هر رفرش توکن جدید تولید کند)
- [ ] Token Blacklist (غیرفعال کردن توکن‌های قدیم)
- [ ] Rate Limiting (محدود کردن تعداد رفرش‌ها)
- [ ] Token Expiry Log (ثبت زمان انقضای توکن‌ها)
- [ ] Device Management (رفرش برای دستگاه‌های مختلف)

---

## ✅ Checklist

- [x] DTO برای RefreshTokenRequest
- [x] Method `refreshToken()` در AuthService
- [x] Endpoint جدید در AuthController
- [x] JwtService بهبود یافته برای توکن‌های منقضی
- [x] SecurityConfig بروزرسانی شده
- [x] کامنت‌های فارسی
- [x] راهنمای جامع
- [x] مثال‌های عملی
- [x] توثیقات کامل

---

**وضعیت**: ✅ تکمیل شده و آماده استفاده

**آخرین تغییر**: 28 تیر 1403 (2024-04-28)

