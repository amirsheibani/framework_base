package info.amirdeveloper.form_generator_service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * کلاس Entry Point اپلیکیشن Spring Boot
 *
 * این کلاس:
 * - نقطه شروع اپلیکیشن است
 * - تمام تنظیمات خودکار Spring Boot را فعال می‌کند
 * - تمام package‌های زیر تا package‌های سطح بالا را scan می‌کند
 *
 * @SpringBootApplication مجموعه‌ای از annotation‌ها است:
 * - @Configuration: این کلاس را به عنوان Bean Configuration معرفی می‌کند
 * - @EnableAutoConfiguration: Spring Boot را تحریک می‌کند تا با توجه به classpath به صورت خودکار تنظیم کند
 * - @ComponentScan: تمام component‌ها، service‌ها و controller‌ها را جستجو می‌کند
 */
@SpringBootApplication
public class FormGeneratorServiceApplication {

    /**
     * متد main برای اجرای اپلیکیشن
     *
     * @param args آرگومان‌های Command Line
     */
    public static void main(String[] args) {
        SpringApplication.run(FormGeneratorServiceApplication.class, args);
    }
}
