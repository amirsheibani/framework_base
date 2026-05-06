# 🔄 راهنمای Refresh Token

## معنی و مقصد

**Refresh Token** یک عملیات برای تولید یک توکن JWT جدید است بدون اینکه کاربر دوباره وارد شود.

### چرا نیاز به Refresh Token داریم؟

```
❌ مسئله: اگر JWT فقط 24 ساعت معتبر باشد
└─ کاربر باید هر 24 ساعت دوباره وارد شود

✅ راه‌حل: Refresh Token
└─ کاربر می‌تواند توکن قدیم را رفرش کند
└─ توکن جدید میگیرد بدون ورود دوباره
```

---

## نحوه کار

```
┌────────────────────────────────────────────┐
│          Refresh Token Flow                │
├────────────────────────────────────────────┤
│                                            │
│  1. کاربر دارای توکن قدیمی است          │
│     توکن منقضی شده یا در حال منقضی       │
│                                            │
│  2. کاربر درخواست رفرش می‌فرستد          │
│     POST /api/auth/refresh                │
│     Body: { "token": "OLD_TOKEN" }        │
│                                            │
│  3. سرور بررسی می‌کند:                   │
│     ✓ فرمت توکن صحیح است؟               │
│     ✓ امضا معتبر است؟                     │
│                                            │
│  4. سرور توکن جدید تولید می‌کند         │
│     توکن جدید مجددا 24 ساعت معتبر است │
│                                            │
│  5. کاربر توکن جدید را دریافت می‌کند     │
│     Response: { "token": "NEW_TOKEN" }    │
│                                            │
└────────────────────────────────────────────┘
```

---

## API Endpoint

### POST /api/auth/refresh

تولید یک توکن JWT جدید از یک توکن قدیم

```http
POST /api/auth/refresh
Content-Type: application/json

{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ1c2VyQGV4YW1wbGUuY29tIiwiaWF0IjoxNjIyNTQ3NjAwLCJleHAiOjE2MjI2MzQwMDB9.SIGNATURE"
}
```

### Response (200 OK)

```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ1c2VyQGV4YW1wbGUuY29tIiwiaWF0IjoxNjIyNjM0MDAwLCJleHAiOjE2MjI3MjA0MDB9.NEW_SIGNATURE"
}
```

---

## مثال‌های عملی

### 1️⃣ استفاده از cURL

```bash
# توکن قدیم را نگه‌دارید
OLD_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."

# درخواست رفرش
curl -X POST http://localhost:8081/api/auth/refresh \
  -H "Content-Type: application/json" \
  -d "{\"token\": \"$OLD_TOKEN\"}"

# پاسخ:
# {
#   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
# }
```

### 2️⃣ استفاده از JavaScript/Fetch API

```javascript
// توکن قدیم
const oldToken = localStorage.getItem('authToken');

// درخواست رفرش
const response = await fetch('http://localhost:8081/api/auth/refresh', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    token: oldToken
  })
});

// پاسخ
const data = await response.json();

// ذخیره توکن جدید
localStorage.setItem('authToken', data.token);
console.log('توکن جدید:', data.token);
```

### 3️⃣ استفاده از Python

```python
import requests
import json

# توکن قدیم
old_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."

# درخواست رفرش
response = requests.post(
    'http://localhost:8081/api/auth/refresh',
    headers={'Content-Type': 'application/json'},
    json={'token': old_token}
)

# پاسخ
data = response.json()
new_token = data['token']
print(f"توکن جدید: {new_token}")
```

### 4️⃣ استفاده از Axios (JavaScript)

```javascript
import axios from 'axios';

// توکن قدیم
const oldToken = localStorage.getItem('authToken');

// درخواست رفرش
axios.post('http://localhost:8081/api/auth/refresh', {
  token: oldToken
})
.then(response => {
  // ذخیره توکن جدید
  localStorage.setItem('authToken', response.data.token);
  console.log('توکن رفرش شد:', response.data.token);
})
.catch(error => {
  console.error('خطا در رفرش توکن:', error);
});
```

---

## حالات مختلف

### ✅ موفقیت
```
Request:
POST /api/auth/refresh
{ "token": "VALID_TOKEN" }

Response (200):
{ "token": "NEW_VALID_TOKEN" }
```

### ❌ توکن خالی
```
Request:
POST /api/auth/refresh
{ "token": "" }

Response (400):
{
  "error": "Token is required",
  "status": 400
}
```

### ❌ توکن نامعتبر
```
Request:
POST /api/auth/refresh
{ "token": "INVALID_FORMAT" }

Response (400):
{
  "error": "Invalid token",
  "status": 400
}
```

### ⚠️ توکن منقضی‌شده

**نکته مهم**: این endpoint حتی برای توکن‌های منقضی‌شده هم کار می‌کند!

```
Request:
POST /api/auth/refresh
{ "token": "EXPIRED_TOKEN" }

Response (200):
{ "token": "NEW_FRESH_TOKEN" }
```

---

## بهترین روش‌ها

### 1️⃣ زمان رفرش کردن

```javascript
// روش 1: بررسی قبل از هر درخواست
function getAuthHeader() {
  const token = localStorage.getItem('authToken');
  const expiryTime = localStorage.getItem('tokenExpiry');
  
  // اگر کمتر از 5 دقیقه تا انقضا مانده
  if (Date.now() > expiryTime - 5 * 60 * 1000) {
    refreshToken(); // رفرش کن
  }
  
  return `Bearer ${token}`;
}

// روش 2: رفرش خودکار هر 20 ساعت
setInterval(() => {
  refreshToken();
}, 20 * 60 * 60 * 1000);
```

### 2️⃣ ذخیره توکن

```javascript
// ذخیره امن توکن
localStorage.setItem('authToken', response.data.token);

// یا برای محیط تولید (بهتر است)
sessionStorage.setItem('authToken', response.data.token);
```

### 3️⃣ Interceptor برای خودکار کردن

```javascript
// Axios Interceptor
interceptor.response.use(
  response => response,
  async error => {
    if (error.response.status === 401) {
      // توکن منقضی‌شده
      const newToken = await refreshToken();
      // درخواست را دوباره امتحان کن
    }
    return Promise.reject(error);
  }
);
```

---

## مخطط زمانی

```
┌─────────────────────────────────────────────────────┐
│           JWT Token Lifecycle                       │
├─────────────────────────────────────────────────────┤
│                                                     │
│ Time:  00:00          12:00           23:50  24:00 │
│  │      │              │               │      │    │
│  ├─────────────────────────────────────┤      │    │
│  │     Token معتبر است                │      │    │
│  └─────────────────────────────────────┴──────┤    │
│         ✓               ✓               ⚠️    ❌   │
│     سرویس‌ها         سرویس‌ها      Refresh   Expire │
│      قبول            قبول           باید!    شده   │
│                                                     │
│  جدول‌سازی:                                      │
│  ├─ 00:00: کاربر وارد می‌شود                      │
│  ├─ 12:00: توکن هنوز معتبر است                  │
│  ├─ 23:50: توکن در حال انقضا است                │
│  │        └─> refreshToken() فراخوانی کن         │
│  │        └─> توکن جدید دریافت کن                │
│  └─ 24:00: توکن قدیم منقضی شود                   │
│           لکن توکن جدید هنوز معتبر است!         │
│                                                     │
└─────────────────────────────────────────────────────┘
```

---

## سناریو عملی

### سناریو: session طولانی مدت

```javascript
// 1. کاربر وارد می‌شود
const loginResponse = await fetch('/api/auth/login', {
  method: 'POST',
  body: JSON.stringify({ email, password })
});
const { token } = await loginResponse.json();
localStorage.setItem('authToken', token);

// 2. کاربر سایت را مرور می‌کند (ساعت‌ها)
// هر درخواست API از این توکن استفاده می‌کند

// 3. توکن 20 ساعت بعد به انقضا نزدیک می‌شود
// سیستم به صورت خودکار رفرش می‌کند:
const refreshResponse = await fetch('/api/auth/refresh', {
  method: 'POST',
  body: JSON.stringify({ token: localStorage.getItem('authToken') })
});
const { token: newToken } = await refreshResponse.json();
localStorage.setItem('authToken', newToken);

// 4. کاربر بدون قطع کار ادامه می‌دهد!
```

---

## Endpoints خلاصه

| Endpoint | روش | توضیح | احراز هویت |
|----------|------|---------|-----------|
| /api/auth/register | POST | ثبت‌نام | ❌ |
| /api/auth/login | POST | ورود | ❌ |
| /api/auth/refresh | POST | **رفرش توکن** | ❌ |
| /api/projects | GET | دریافت پروژه‌ها | ✅ |

---

**آخرین بروزرسانی**: 28 تیر 1403 (2024-04-28)

