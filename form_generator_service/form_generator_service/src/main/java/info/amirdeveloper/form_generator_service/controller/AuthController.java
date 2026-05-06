package info.amirdeveloper.form_generator_service.controller;

import info.amirdeveloper.form_generator_service.dto.auth.AuthResponse;
import info.amirdeveloper.form_generator_service.dto.auth.LoginRequest;
import info.amirdeveloper.form_generator_service.dto.auth.RefreshTokenRequest;
import info.amirdeveloper.form_generator_service.dto.auth.RegisterRequest;
import info.amirdeveloper.form_generator_service.service.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * Controller کلاس برای مدیریت درخواست‌های احراز هویت
 * این controller سه endpoint برای ثبت‌نام و ورود کاربران را فراهم می‌کند
 *
 * Annotations:
 * - @RestController: مشخص می‌کند که این کلاس یک REST API controller است
 * - @RequestMapping("/api/auth"): تمام endpoint‌های این controller در محل /api/auth قرار می‌گیرند
 * - @RequiredArgsConstructor: ایجاد constructor برای dependency injection
 */
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    /** Service برای مدیریت احراز هویت */
    private final AuthService authService;

    /**
     * API Endpoint برای ثبت‌نام کاربر جدید
     *
     * درخواست PUT (Public - بدون احراز هویت):
     * URL: POST /api/auth/register
     * Body: {
     *   "name": "نام کاربر",
     *   "email": "user@example.com",
     *   "password": "رمزعبور"
     * }
     *
     * پاسخ (200 OK):
     * {
     *   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
     * }
     *
     * @param request درخواست ثبت‌نام شامل نام، ایمیل و رمز عبور
     * @return AuthResponse شامل توکن JWT
     */
    @PostMapping("/register")
    public AuthResponse register(@RequestBody RegisterRequest request) {
        return authService.register(request);
    }

    /**
     * API Endpoint برای ورود کاربری موجود
     *
     * درخواست POST (Public - بدون احراز هویت):
     * URL: POST /api/auth/login
     * Body: {
     *   "email": "user@example.com",
     *   "password": "رمزعبور"
     * }
     *
     * پاسخ (200 OK):
     * {
     *   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
     * }
     *
     * @param request درخواست ورود شامل ایمیل و رمز عبور
     * @return AuthResponse شامل توکن JWT
     */
    @PostMapping("/login")
    public AuthResponse login(@RequestBody LoginRequest request) {
        return authService.login(request);
    }

    /**
     * API Endpoint برای رفرش توکن (تولید توکن جدید)
     *
     * درخواست POST (Public - بدون احراز هویت):
     * URL: POST /api/auth/refresh
     * Body: {
     *   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
     * }
     *
     * پاسخ (200 OK):
     * {
     *   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
     * }
     *
     * نکته: این endpoint حتی اگر توکن منقضی شده باشد هم کار می‌کند
     *
     * مثال استفاده:
     * curl -X POST http://localhost:8081/api/auth/refresh \
     *   -H "Content-Type: application/json" \
     *   -d '{"token": "OLD_JWT_TOKEN"}'
     *
     * @param request درخواست رفرش شامل توکن قدیم
     * @return AuthResponse شامل توکن جدید
     */
    @PostMapping("/refresh")
    public AuthResponse refresh(@RequestBody RefreshTokenRequest request) {
        return authService.refreshToken(request);
    }
}