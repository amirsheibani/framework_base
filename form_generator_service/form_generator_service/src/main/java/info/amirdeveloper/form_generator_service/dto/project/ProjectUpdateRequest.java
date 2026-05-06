package info.amirdeveloper.form_generator_service.dto.project;

import lombok.Data;

/**
 * DTO کلاس ProjectUpdateRequest برای دریافت اطلاعات بروزرسانی پروژه
 * این کلاس برای درخواست‌های HTTP PUT به endpoint /api/projects/{id} استفاده می‌شود
 * 
 * @Data: ایجاد خودکار getter، setter و toString
 */
@Data
public class ProjectUpdateRequest {
    
    /** نام جدید پروژه */
    private String name;
    
    /** توضیح جدید پروژه */
    private String description;
}