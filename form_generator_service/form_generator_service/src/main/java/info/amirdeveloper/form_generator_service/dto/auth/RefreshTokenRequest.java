package info.amirdeveloper.form_generator_service.dto.auth;

import lombok.Data;

/**
 * DTO کلاس RefreshTokenRequest برای درخواست رفرش توکن
 * این کلاس برای درخواست‌های HTTP POST به endpoint /api/auth/refresh استفاده می‌شود
 *
 * @Data: ایجاد خودکار getter، setter و toString
 */
@Data
public class RefreshTokenRequest {

    /** توکن JWT قدیم که می‌خواهیم آن را رفرش کنیم */
    private String token;
}

