package info.amirdeveloper.form_generator_service.dto.auth;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * DTO کلاس AuthResponse برای ارسال نتیجه احراز هویت
 * این کلاس پاسخ بازگشتی برای درخواست‌های ثبت‌نام و ورود است
 * 
 * Annotations:
 * - @Data: ایجاد خودکار getter، setter و toString
 * - @AllArgsConstructor: سازنده با تمام پارامترها
 */
@Data
@AllArgsConstructor
public class AuthResponse {

    /** Access Token JWT که برای احراز هویت درخواست‌های بعدی استفاده می‌شود (اعتبار: 2 روز) */
    private String accessToken;

    /** Refresh Token JWT که برای دریافت access token جدید استفاده می‌شود (اعتبار: 7 روز) */
    private String refreshToken;
}