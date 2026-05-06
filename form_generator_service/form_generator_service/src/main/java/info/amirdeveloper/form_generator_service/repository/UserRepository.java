package info.amirdeveloper.form_generator_service.repository;

import info.amirdeveloper.form_generator_service.model.User;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.Optional;

/**
 * Repository Interface برای مدیریت عملیات CRUD کاربران در MongoDB
 * MongoRepository توابع CRUD استاندارد را فراهم می‌کند
 */
public interface UserRepository extends MongoRepository<User, String> {

    /**
     * جستجو برای کاربری بر اساس ایمیل
     * @param email ایمیلی که جستجو می‌کنیم
     * @return Optional شامل کاربر اگر یافت شود
     */
    Optional<User> findByEmail(String email);

    /**
     * بررسی کنید که آیا یک ایمیل در سیستم موجود است یا خیر
     * @param email ایمیلی که بررسی می‌کنیم
     * @return true اگر ایمیل موجود باشد، false در غیر اینصورت
     */
    boolean existsByEmail(String email);
}