package info.amirdeveloper.form_generator_service.dto.auth;

import lombok.Data;

/**
 * DTO کلاس LoginRequest برای دریافت اطلاعات ورود کاربر
 * این کلاس برای درخواست‌های HTTP POST به endpoint /api/auth/login استفاده می‌شود
 *
 * @Data: ایجاد خودکار getter, setter و toString
 */
@Data
public class LoginRequest {

    /** آدرس ایمیل کاربر برای ورود */
    private String email;

    /** رمز عبور کاربر */
    private String password;
}
