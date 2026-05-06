package info.amirdeveloper.form_generator_service.dto.project;

import lombok.Data;

/**
 * DTO کلاس ProjectCreateRequest برای دریافت اطلاعات ایجاد پروژه جدید
 * این کلاس برای درخواست‌های HTTP POST به endpoint /api/projects استفاده می‌شود
 *
 * @Data: ایجاد خودکار getter، setter و toString
 */
@Data
public class ProjectCreateRequest {

    /** نام پروژه جدید */
    private String name;

    /** توضیح و شرح پروژه جدید */
    private String description;
}