package info.amirdeveloper.form_generator_service.config;

import org.springframework.context.annotation.Configuration;

/**
 * Config کلاس برای تنظیمات Swagger/OpenAPI
 *
 * این کلاس برای تنظیمات خودکار Swagger documentation استفاده می‌شود
 * SpringDoc-OpenAPI تنظیمات Swagger را به صورت خودکار از Application مدیریت می‌کند
 *
 * بدون نیاز به تنظیمات دستی، تمام endpoint‌ها و model‌ها به صورت خودکار
 * در Swagger UI ظاهر می‌شوند (http://localhost:8081/swagger-ui.html)
 */
@Configuration
public class SwaggerConfig {
    // Configuration is handled automatically by springdoc.
}