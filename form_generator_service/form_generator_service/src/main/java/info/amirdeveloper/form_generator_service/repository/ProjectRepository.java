package info.amirdeveloper.form_generator_service.repository;

import info.amirdeveloper.form_generator_service.model.Project;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

/**
 * Repository Interface برای مدیریت عملیات CRUD پروژه‌ها در MongoDB
 * MongoRepository توابع CRUD استاندارد را فراهم می‌کند
 */
public interface ProjectRepository extends MongoRepository<Project, String> {

    /**
     * جستجو برای تمام پروژه‌های متعلق به یک کاربر
     * @param userId شناسه کاربری که پروژه‌های او را می‌خواهیم
     * @return لیستی از پروژه‌های متعلق به کاربر
     */
    List<Project> findByUserId(String userId);
}
