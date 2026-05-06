package info.amirdeveloper.form_generator_service.dto.auth;

import lombok.Data;

/**
 * DTO کلاس RegisterRequest برای دریافت اطلاعات ثبت‌نام کاربر جدید
 * این کلاس برای درخواست‌های HTTP POST به endpoint /api/auth/register استفاده می‌شود
 *
 * @Data: ایجاد خودکار getter، setter و toString
 */
@Data
public class RegisterRequest {

    /** نام کاربر */
    private String name;

    /** آدرس ایمیل کاربر (باید منحصربه‌فرد باشد) */
    private String email;

    /** رمز عبور درخواست‌شده */
    private String password;
}