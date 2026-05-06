# 📋 Form Generator Service

## نمای کلی پروژه

**Form Generator Service** یک سرویس تولید فرم‌های پویا است که توسط **Spring Boot** و **MongoDB** ساخته شده‌است. این سرویس کاربران را قادر می‌سازد تا:

- ثبت‌نام و ورود به سیستم
- پروژه‌های خود را ایجاد، مشاهده، بروزرسانی و حذف کنند (CRUD)
- فرم‌های پویا را مدیریت کنند
- احراز هویت توکن‌های JWT را استفاده کنند

---

## 📁 ساختار پروژه

```
form_generator_service/
│
├── src/
│   ├── main/
│   │   ├── java/info/amirdeveloper/form_generator_service/
│   │   │   ├── FormGeneratorServiceApplication.java          # کلاس Main
│   │   │   │
│   │   │   ├── config/                                        # کلاس‌های تنظیمات
│   │   │   │   ├── ApplicationConfig.java                    # تنظیمات عام اپلیکیشن
│   │   │   │   ├── SecurityConfig.java                       # تنظیمات امنیتی Spring Security
│   │   │   │   └── SwaggerConfig.java                        # تنظیمات Swagger/OpenAPI
│   │   │   │
│   │   │   ├── controller/                                    # REST API Controllers
│   │   │   │   ├── AuthController.java                       # معامله احراز هویت (ثبت‌نام و ورود)
│   │   │   │   └── ProjectController.java                    # معامله پروژه‌ها (CRUD)
│   │   │   │
│   │   │   ├── model/                                         # Entity کلاس‌ها (MongoDB Documents)
│   │   │   │   ├── User.java                                 # مدل کاربر
│   │   │   │   └── Project.java                              # مدل پروژه
│   │   │   │
│   │   │   ├── repository/                                    # Data Access Layer
│   │   │   │   ├── UserRepository.java                       # CRUD عملیات برای User
│   │   │   │   └── ProjectRepository.java                    # CRUD عملیات برای Project
│   │   │   │
│   │   │   ├── service/                                       # Business Logic
│   │   │   │   ├── AuthService.java                          # منطق احراز هویت
│   │   │   │   ├── ProjectService.java                       # منطق پروژه‌ها
│   │   │   │   └── CustomUserDetailsService.java             # User Details برای Spring Security
│   │   │   │
│   │   │   ├── security/                                      # امنیت JWT
│   │   │   │   ├── JwtService.java                           # تولید و تأیید JWT Token
│   │   │   │   └── JwtAuthenticationFilter.java              # Filter برای بررسی JWT
│   │   │   │
│   │   │   ├── dto/                                           # Data Transfer Objects
│   │   │   │   ├── auth/
│   │   │   │   │   ├── LoginRequest.java                     # درخواست ورود
│   │   │   │   │   ├── RegisterRequest.java                  # درخواست ثبت‌نام
│   │   │   │   │   └── AuthResponse.java                     # پاسخ احراز هویت
│   │   │   │   └── project/
│   │   │   │       ├── ProjectCreateRequest.java             # درخواست ایجاد پروژه
│   │   │   │       ├── ProjectUpdateRequest.java             # درخواست بروزرسانی پروژه
│   │   │   │       └── ProjectResponse.java                  # پاسخ پروژه
│   │   │   │
│   │   │   └── exception/                                     # کلاس‌های Exception
│   │   │
│   │   └── resources/
│   │       └── application.properties                         # تنظیمات اپلیکیشن
│   │
│   └── test/                                                  # تست‌های واحد
│
├── pom.xml                                                    # Maven Configuration
├── README_FA.md                                               # فایل توضیحات فارسی
└── README.md                                                  # فایل توضیحات انگلیسی
```

---

## 🏗️ معماری و الگوی طراحی

### معماری Layered

پروژه از معماری لایه‌ای استفاده می‌کند:

```
┌─────────────────────────────────────────┐
│      REST API (Controller Layer)        │
├─────────────────────────────────────────┤
│      Business Logic (Service Layer)     │
├─────────────────────────────────────────┤
│      Data Access (Repository Layer)     │
├─────────────────────────────────────────┤
│      Database (MongoDB)                 │
└─────────────────────────────────────────┘
```

### الگوهای استفاده‌شده

- **Repository Pattern**: برای دسترسی به داده‌ها
- **Service Pattern**: برای منطق تجاری
- **DTO Pattern**: برای انتقال داده‌ها بین لایه‌ها
- **Filter Pattern**: برای بررسی JWT
- **Builder Pattern**: با استفاده از Lombok

---

## 🔧 تکنولوژی‌های استفاده‌شده

### Dependencies اصلی

| تکنولوژی | نسخه | توضیح |
|----------|------|---------|
| Spring Boot | 3.2.5 | Framework اصلی |
| MongoDB | - | دیتابیس NoSQL |
| Spring Security | - | احراز هویت و مجوز |
| JWT (JJWT) | 0.11.5 | توکن‌های Web |
| Lombok | 1.18.30 | کاهش Boilerplate Code |
| MapStruct | 1.5.5 | تبدیل Object‌ها |
| Swagger/OpenAPI | 2.5.0 | API Documentation |
| Spring Data MongoDB | - | شی‌گرا برای MongoDB |

### Java Version

- **Java 17+**

---

## 🚀 نحوه نصب و اجرا

### پیش‌نیاز‌ها

1. **Java 17+**
2. **Maven 3.6+**
3. **MongoDB** (به طور محلی یا دور افتاده)

### مراحل نصب

#### 1. Clone کردن پروژه

```bash
git clone <repository-url>
cd form_generator_service
```

#### 2. MongoDB را راه‌اندازی کنید

اگر MongoDB را محلی نصب کرده‌اید:

```bash
# macOS (با Homebrew)
brew services start mongodb-community

# یا اجرا به صورت دستی
mongod
```

#### 3. تنظیمات اپلیکیشن

فایل `application.properties` را بررسی کنید:

```properties
# Connection String MongoDB
spring.data.mongodb.uri=mongodb://localhost:27017/form-generator-db

# نام اپلیکیشن
spring.application.name=form-generator-service

# پورت سرور
server.port=8081

# لاگ‌های MongoDB
logging.level.org.springframework.data.mongodb=DEBUG
```

#### 4. ساخت و اجرا

```bash
# کامپایل و پکیچ کردن
mvn clean package

# اجرای اپلیکیشن
mvn spring-boot:run

# یا اجرای فایل JAR
java -jar target/form_generator_service-1.0.0.jar
```

سرور روی `http://localhost:8081` اجرا می‌شود.

### دسترسی به Swagger UI

بعد از اجرا، می‌توانید API Documentation را در انجام ببینید:

```
http://localhost:8081/swagger-ui.html
```

---

## 🔐 احراز هویت و JWT

### نمای کلی

سیستم از **JWT (JSON Web Token)** برای احراز هویت stateless استفاده می‌کند:

1. کاربر **ثبت‌نام** یا **وارد می‌شود**
2. سرور یک **JWT Token** تولید می‌کند
3. کاربر این **Token** را در هر درخواست ارسال می‌کند
4. سرور **Token** را تأیید می‌کند و درخواست را اجرا می‌کند

### Security Configuration

```java
// Endpoint‌های عمومی (بدون احراز هویت)
- POST /api/auth/register
- POST /api/auth/login
- GET  /swagger-ui/**
- GET  /v3/api-docs/**

// Endpoint‌های محافظت‌شده (نیاز به JWT)
- POST   /api/projects
- GET    /api/projects
- GET    /api/projects/{id}
- PUT    /api/projects/{id}
- DELETE /api/projects/{id}
```

### استفاده از JWT در درخواست‌ها

تمام درخواست‌های به endpoint‌های محافظت‌شده باید header زیر را شامل کنند:

```
Authorization: Bearer <JWT_TOKEN>
```

### مثال: استخراج Token

```bash
# ثبت‌نام
curl -X POST http://localhost:8081/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "علی محمدی",
    "email": "ali@example.com",
    "password": "password123"
  }'

# Response
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

---

## 📡 REST API Endpoints

### Authentication Endpoints

#### ثبت‌نام کاربر جدید

```
POST /api/auth/register
Content-Type: application/json

Body:
{
  "name": "نام کاربر",
  "email": "user@example.com",
  "password": "رمزعبور"
}

Response (200):
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

#### ورود کاربر

```
POST /api/auth/login
Content-Type: application/json

Body:
{
  "email": "user@example.com",
  "password": "رمزعبور"
}

Response (200):
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

### Projects Endpoints

#### ایجاد پروژه جدید

```
POST /api/projects
Authorization: Bearer <TOKEN>
Content-Type: application/json

Body:
{
  "name": "نام پروژه",
  "description": "توضیح پروژه"
}

Response (200):
{
  "id": "507f1f77bcf86cd799439011",
  "name": "نام پروژه",
  "description": "توضیح پروژه",
  "createdAt": "2024-04-28T10:30:00Z",
  "updatedAt": "2024-04-28T10:30:00Z"
}
```

#### دریافت تمام پروژه‌های کاربر

```
GET /api/projects
Authorization: Bearer <TOKEN>

Response (200):
[
  {
    "id": "507f1f77bcf86cd799439011",
    "name": "پروژه 1",
    "description": "توضیح اول",
    "createdAt": "2024-04-28T10:30:00Z",
    "updatedAt": "2024-04-28T10:30:00Z"
  },
  ...
]
```

#### دریافت یک پروژه با ID

```
GET /api/projects/{id}
Authorization: Bearer <TOKEN>

Response (200):
{
  "id": "507f1f77bcf86cd799439011",
  "name": "نام پروژه",
  "description": "توضیح پروژه",
  "createdAt": "2024-04-28T10:30:00Z",
  "updatedAt": "2024-04-28T10:30:00Z"
}
```

#### بروزرسانی پروژه

```
PUT /api/projects/{id}
Authorization: Bearer <TOKEN>
Content-Type: application/json

Body:
{
  "name": "نام جدید",
  "description": "توضیح جدید"
}

Response (200):
{
  "id": "507f1f77bcf86cd799439011",
  "name": "نام جدید",
  "description": "توضیح جدید",
  "createdAt": "2024-04-28T10:30:00Z",
  "updatedAt": "2024-04-28T11:45:00Z"
}
```

#### حذف پروژه

```
DELETE /api/projects/{id}
Authorization: Bearer <TOKEN>

Response (204):
No Content
```

---

## 📊 ساختار دیتابیس

### MongoDB Collections

#### users Collection

```json
{
  "_id": "ObjectId",
  "email": "user@example.com",
  "password": "bcrypt-hashed-password",
  "name": "نام کاربر"
}
```

#### projects Collection

```json
{
  "_id": "ObjectId",
  "userId": "user-id",
  "name": "نام پروژه",
  "description": "توضیح پروژه",
  "createdAt": "2024-04-28T10:30:00Z",
  "updatedAt": "2024-04-28T10:30:00Z"
}
```

---

## 📝 توضیح تفصیلی اجزای Main

### 1. Models (مدل‌های داده)

#### User.java

```java
/**
 * مدل کاربر برای ذخیره اطلاعات کاربران
 * Fields:
 * - id: شناسه منحصربه‌فرد
 * - email: آدرس ایمیل (منحصربه‌فرد)
 * - password: رمز عبور رمزنشده با BCrypt
 * - name: نام کاربر
 */
```

#### Project.java

```java
/**
 * مدل پروژه برای ذخیره اطلاعات پروژه‌ها
 * 
 * Fields:
 * - id: شناسه منحصربه‌فرد
 * - userId: شناسه کاربری که مالک پروژه است
 * - name: نام پروژه
 * - description: توضیح پروژه
 * - createdAt: زمان ایجاد
 * - updatedAt: زمان آخرین بروزرسانی
 */
```

### 2. Controllers (کنترل‌کننده‌ها)

#### AuthController

- `POST /api/auth/register`: ثبت‌نام کاربر
- `POST /api/auth/login`: ورود کاربر

#### ProjectController

- `POST /api/projects`: ایجاد پروژه (Create)
- `GET /api/projects`: دریافت تمام پروژه‌ها (Read)
- `GET /api/projects/{id}`: دریافت یک پروژه (Read)
- `PUT /api/projects/{id}`: بروزرسانی پروژه (Update)
- `DELETE /api/projects/{id}`: حذف پروژه (Delete)

### 3. Services (سرویس‌ها)

#### AuthService

```java
/**
 * منطق احراز هویت
 * 
 * Methods:
 * - register(RegisterRequest): ثبت‌نام کاربر جدید
 * - login(LoginRequest): ورود کاربر موجود
 */
```

#### ProjectService

```java
/**
 * منطق مدیریت پروژه‌ها
 * 
 * Methods:
 * - create(ProjectCreateRequest): ایجاد پروژه
 * - getAll(): دریافت تمام پروژه‌های کاربر فعلی
 * - getById(String id): دریافت یک پروژه
 * - update(String id, ProjectUpdateRequest): بروزرسانی
 * - delete(String id): حذف پروژه
 * - validateOwnership(String id): بررسی مالکیت
 */
```

### 4. Security (امنیت)

#### JwtService

```java
/**
 * مدیریت JWT Token
 * 
 * Methods:
 * - generateToken(String email): تولید token
 * - extractEmail(String token): استخراج ایمیل
 * - isTokenValid(String token): بررسی اعتبار
 */
```

#### JwtAuthenticationFilter

```java
/**
 * Filter برای بررسی JWT در هر درخواست
 * 
 * Process:
 * 1. استخراج JWT از header
 * 2. استخراج ایمیل از JWT
 * 3. بررسی اعتبار JWT
 * 4. ذخیره اطلاعات احراز هویت
 */
```

---

## 🧪 مثال‌های عملی

### استفاده از cURL

#### 1. ثبت‌نام

```bash
curl -X POST http://localhost:8081/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "محمد احمدی",
    "email": "mohammad@example.com",
    "password": "secure123"
  }'
```

#### 2. ورود

```bash
curl -X POST http://localhost:8081/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "mohammad@example.com",
    "password": "secure123"
  }'
```

#### 3. ایجاد پروژه

```bash
TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."

curl -X POST http://localhost:8081/api/projects \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "name": "پروژه نمونه",
    "description": "این یک پروژه نمونه است"
  }'
```

#### 4. دریافت تمام پروژه‌ها

```bash
TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."

curl -X GET http://localhost:8081/api/projects \
  -H "Authorization: Bearer $TOKEN"
```

#### 5. بروزرسانی پروژه

```bash
TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
PROJECT_ID="507f1f77bcf86cd799439011"

curl -X PUT http://localhost:8081/api/projects/$PROJECT_ID \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "name": "نام بروز‌شده",
    "description": "توضیح بروز‌شده"
  }'
```

#### 6. حذف پروژه

```bash
TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
PROJECT_ID="507f1f77bcf86cd799439011"

curl -X DELETE http://localhost:8081/api/projects/$PROJECT_ID \
  -H "Authorization: Bearer $TOKEN"
```

---

## 🔒 نکات امنیتی

### بهترین روش‌ها

1. **کلید محرمانه JWT**
   - در محیط تولید، کلید را از Environment Variables بخوانید
   - کلید را هرگز در کد قرار ندهید

```java
private final String SECRET_KEY = System.getenv("JWT_SECRET_KEY");
```

2. **تاریخ انقضای Token**
   - فعلاً 24 ساعت است
   - برای محیط تولید، مقدار مناسب‌تری انتخاب کنید

3. **رمزنشانی رمز عبور**
   - از BCryptPasswordEncoder استفاده می‌شود
   - هرگز رمز عبور را plain text ذخیره نکنید

4. **HTTPS**
   - در محیط تولید، از HTTPS استفاده کنید

---

## 🧬 توسعه و بهبودی‌های آینده

### ویژگی‌های در نظر گرفته‌شده

- [ ] مدل Form و Field
- [ ] Submission و Response Handling
- [ ] User Permissions و Role-Based Access Control
- [ ] Email Verification
- [ ] Password Reset
- [ ] API Rate Limiting
- [ ] Caching (Redis)
- [ ] Unit Tests
- [ ] Integration Tests
- [ ] CI/CD Pipeline

---

## 🐛 عیب‌یابی

### مسائل رایج

#### 1. MongoDB Connection Error

**خطا**: `Unable to connect to MongoDB`

**حل**:
- MongoDB را راه‌اندازی کنید
- Connection String را بررسی کنید
- پورت MongoDB (27017) باز است یا نه

#### 2. JWT Token Invalid

**خطا**: `Invalid JWT Token`

**حل**:
- Token را صحیح کپی کنید
- Token منقضی شده است؟
- کلید محرمانه JWT برابر است؟

#### 3. CORS Issues

**خطا**: `CORS policy: No 'Access-Control-Allow-Origin'`

**حل**:
- CORS Configuration اضافه کنید
- یا از Proxy استفاده کنید

---

## 📞 تماس و پشتیبانی

برای پرسش‌ها و مشاوره‌ها:

- **Email**: [amir.developer@example.com]
- **GitHub**: [@amirsheibanimadrahi]
- **Documentation**: See inline comments in source code (Persian)

---

## 📄 License

این پروژه تحت [MIT License] منتشر شده است.

---

## ✅ Checklist

- [x] کامنت‌های فارسی برای تمام کلاس‌ها
- [x] کامنت‌های فارسی برای تمام توابع
- [x] README فراجامع به فارسی
- [x] مثال‌های عملی REST API
- [x] نمودار معماری
- [x] توضیح ساختار دیتابیس
- [x] نکات امنیتی
- [x] راهنمای نصب و اجرا

---

**آخرین بروزرسانی**: 28 تیر 1403 (2024-04-28)

**نسخه**: 1.0.0

**توسعه‌دهنده**: Amir Sheibani Madrahi

