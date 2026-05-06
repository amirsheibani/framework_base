package info.amirdeveloper.form_generator_service.model;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.Instant;

/**
 * Model کلاس Project برای ذخیره اطلاعات پروژه‌ها در MongoDB
 * هر پروژه متعلق به یک کاربر است و شامل فرم‌ها و تنظیمات است
 *
 * Annotations:
 * - @Document: مشخص می‌کند که این کلاس در collection "projects" در MongoDB ذخیره می‌شود
 * - @Data: ایجاد خودکار getter, setter, build و...
 * - @Builder: برای ساخت آسان اشیاء پروژه
 * - @NoArgsConstructor: سازنده بدون پارامتر
 * - @AllArgsConstructor: سازنده با تمام پارامترها
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "projects")
public class Project {

    /** شناسه منحصربه‌فرد پروژه در MongoDB */
    @Id
    private String id;

    /** شناسه کاربری که مالک این پروژه است */
    private String userId;

    /** نام پروژه */
    private String name;

    /** توضیح و شرح پروژه */
    private String description;

    /** زمان ایجاد پروژه */
    private Instant createdAt;

    /** زمان آخرین بروزرسانی پروژه */
    private Instant updatedAt;
}
