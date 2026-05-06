package info.amirdeveloper.form_generator_service.dto.project;

import lombok.Builder;
import lombok.Data;

import java.time.Instant;

/**
 * DTO کلاس ProjectResponse برای ارسال اطلاعات پروژه در پاسخ API
 * این کلاس برای بازگشت داده‌های پروژه به کلاینت استفاده می‌شود
 *
 * Annotations:
 * - @Data: ایجاد خودکار getter، setter و toString
 * - @Builder: برای ساخت آسان اشیاء ProjectResponse
 */
@Data
@Builder
public class ProjectResponse {

    /** شناسه منحصربه‌فرد پروژه */
    private String id;

    /** نام پروژه */
    private String name;

    /** توضیح و شرح پروژه */
    private String description;

    /** زمان ایجاد پروژه */
    private Instant createdAt;

    /** زمان آخرین بروزرسانی پروژه */
    private Instant updatedAt;
}
