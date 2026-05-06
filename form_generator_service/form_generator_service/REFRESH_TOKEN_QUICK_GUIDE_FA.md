# 🔄 Refresh Token - خلاصه سریع

## 📋 چه تغییراتی اضافه شدند؟

### ✅ فایل‌های ایجاد شده:
- `RefreshTokenRequest.java` - DTO برای درخواست رفرش

### ✅ فایل‌های بروزرسانی شده:
- `AuthService.java` - تابع `refreshToken()` اضافه شد
- `AuthController.java` - endpoint `POST /api/auth/refresh` اضافه شد  
- `JwtService.java` - `extractEmail()` برای توکن‌های منقضی‌شده بهبود یافت
- `SecurityConfig.java` - endpoint رفرش به عنوان عمومی تنظیم شد

### ✅ فایل‌های توثیقات:
- `REFRESH_TOKEN_GUIDE_FA.md` - راهنمای جامع refresh token

---

## 🚀 نحوه استفاده

### مثال 1: cURL

```bash
# 1. ابتدا وارد شوید
curl -X POST http://localhost:8081/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "password123"
  }'

# Response:
# { "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..." }

# 2. توکن قدیم را نگه‌دارید
TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."

# 3. توکن را رفرش کنید
curl -X POST http://localhost:8081/api/auth/refresh \
  -H "Content-Type: application/json" \
  -d "{ \"token\": \"$TOKEN\" }"

# Response:
# { "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..." }
```

### مثال 2: JavaScript

```javascript
// 1. دریافت توکن جدید
async function refreshAuthToken() {
  const oldToken = localStorage.getItem('authToken');
  
  const response = await fetch('http://localhost:8081/api/auth/refresh', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ token: oldToken })
  });
  
  const data = await response.json();
  
  // 2. ذخیره توکن جدید
  localStorage.setItem('authToken', data.token);
  
  console.log('✅ توکن رفرش شد!');
  return data.token;
}

// 3. استفاده
await refreshAuthToken();
```

---

## 🔐 نقاط مهم

### ✅ مزایا:
- کاربر نیاز ندارد دوباره وارد شود
- توکن منقضی‌شده هم قابل رفرش است
- endpoint عمومی است (احراز هویت ندارد)

### ⚠️ توجهات:
- توکن باید فرمت صحیح داشته باشد
- امضای توکن باید معتبر باشد
- توکن جدید مجددا 24 ساعت معتبر است

---

## 📊 API Endpoints

```
POST /api/auth/register      ← ثبت‌نام
POST /api/auth/login         ← ورود
POST /api/auth/refresh       ← رفرش توکن ✨ NEW!
GET  /api/projects           ← دریافت پروژه‌ها (نیاز به احراز هویت)
```

---

## 🎯 استراتژی رفرش خودکار

```javascript
// رفرش خودکار قبل از انقضا
setInterval(async () => {
  const authToken = localStorage.getItem('authToken');
  
  if (authToken) {
    try {
      await refreshAuthToken();
      console.log('✅ توکن هر 20 ساعت رفرش می‌شود');
    } catch (error) {
      console.error('❌ خطا در رفرش:', error);
    }
  }
}, 20 * 60 * 60 * 1000); // هر 20 ساعت
```

---

💡 برای اطلاعات مفصل‌تر، فایل `REFRESH_TOKEN_GUIDE_FA.md` را مشاهده کنید.

