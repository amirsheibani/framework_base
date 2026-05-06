package info.amirdeveloper.form_generator_service.model;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 * Model کلاس User برای ذخیره اطلاعات کاربران در MongoDB
 * این کلاس نمایندگی کاربرانی است که در سیستم ثبت‌نام می‌کنند
 *
 * Annotations:
 * - @Document: مشخص می‌کند که این کلاس در collection "users" در MongoDB ذخیره می‌شود
 * - @Data: ایجاد خودکار getter, setter, equals, hashCode و toString
 * - @Builder: الگوی Builder برای ایجاد آسان شی User
 * - @NoArgsConstructor: سازنده بدون پارامتر
 * - @AllArgsConstructor: سازنده با تمام پارامترها
 */
@Document(collection = "users")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class User {

    /** شناسه منحصربه‌فرد کاربر در MongoDB */
    @Id
    private String id;

    /** آدرس ایمیل کاربر (باید منحصربه‌فرد باشد) */
    private String email;

    /** رمز عبور رمزنشده‌شده کاربر */
    private String password;

    /** نام کاربر */
    private String name;
}
