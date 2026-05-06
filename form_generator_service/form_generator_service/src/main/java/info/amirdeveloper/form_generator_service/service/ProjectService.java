package info.amirdeveloper.form_generator_service.service;

import info.amirdeveloper.form_generator_service.dto.project.*;
import info.amirdeveloper.form_generator_service.model.Project;
import info.amirdeveloper.form_generator_service.repository.ProjectRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.List;

/**
 * Service کلاس برای مدیریت پروژه‌ها
 * این کلاس عملیات CRUD پروژه‌ها را انجام می‌دهد
 * و اطمینان می‌دهد که هر کاربر فقط پروژه‌های خود را مدیریت کند
 */
@Service
@RequiredArgsConstructor
public class ProjectService {

    /** Repository برای دسترسی به داده‌های پروژه‌ها */
    private final ProjectRepository projectRepository;

    /** Service برای مدیریت جزئیات کاربران */
    private final CustomUserDetailsService userDetailsService;

    /**
     * دریافت شناسه کاربری فعلی از Security Context
     * استخراج ایمیل کاربر از اطلاعات احراز هویت
     *
     * @return ایمیل کاربری فعلی
     */
    private String getCurrentUserId() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        return auth.getName(); // ایمیل
    }

    /**
     * ایجاد یک پروژه جدید برای کاربر فعلی
     *
     * عملیات:
     * 1. شناسه کاربری فعلی را دریافت می‌کند
     * 2. یک پروژه جدید ایجاد می‌کند
     * 3. پروژه را با timestamp‌های ایجاد و بروزرسانی ذخیره می‌کند
     *
     * @param request درخواست ایجاد شامل نام و توضیح پروژه
     * @return ProjectResponse شامل اطلاعات پروژه ایجاد‌شده
     */
    public ProjectResponse create(ProjectCreateRequest request) {

        String userId = getCurrentUserId();

        // ایجاد پروژه جدید
        Project project = Project.builder()
                .userId(userId)
                .name(request.getName())
                .description(request.getDescription())
                .createdAt(Instant.now())
                .updatedAt(Instant.now())
                .build();

        // ذخیره پروژه در دیتابیس
        projectRepository.save(project);

        // تبدیل به ProjectResponse
        return mapToResponse(project);
    }

    /**
     * دریافت تمام پروژه‌های کاربر فعلی
     *
     * عملیات:
     * 1. شناسه کاربری فعلی را دریافت می‌کند
     * 2. تمام پروژه‌های متعلق به کاربر را جستجو می‌کند
     * 3. آنها را به ProjectResponse تبدیل می‌کند
     *
     * @return لیستی از ProjectResponse برای تمام پروژه‌های کاربر
     */
    public List<ProjectResponse> getAll() {
        String userId = getCurrentUserId();

        // جستجو برای تمام پروژه‌های کاربر و تبدیل به DTO
        return projectRepository.findByUserId(userId)
                .stream()
                .map(this::mapToResponse)
                .toList();
    }

    /**
     * دریافت یک پروژه خاص بر اساس شناسه
     *
     * عملیات:
     * 1. بررسی می‌کند که کاربر مالک این پروژه است
     * 2. پروژه را تبدیل و بازگشت می‌دهد
     *
     * @param id شناسه پروژه
     * @return ProjectResponse شامل اطلاعات پروژه
     * @throws RuntimeException اگر پروژه یافت نشود یا کاربر مالک نباشد
     */
    public ProjectResponse getById(String id) {
        Project project = validateOwnership(id);
        return mapToResponse(project);
    }

    /**
     * بروزرسانی یک پروژه موجود
     *
     * عملیات:
     * 1. بررسی می‌کند که کاربر مالک این پروژه است
     * 2. نام و توضیح را بروزرسانی می‌کند
     * 3. timestamp بروزرسانی را تغییر می‌دهد
     * 4. پروژه را ذخیره می‌کند
     *
     * @param id شناسه پروژه
     * @param request درخواست بروزرسانی شامل نام و توضیح جدید
     * @return ProjectResponse شامل اطلاعات پروژه بروزرسانی‌شده
     * @throws RuntimeException اگر پروژه یافت نشود یا کاربر مالک نباشد
     */
    public ProjectResponse update(String id, ProjectUpdateRequest request) {

        // بررسی مالکیت
        Project project = validateOwnership(id);

        // بروزرسانی اطلاعات
        project.setName(request.getName());
        project.setDescription(request.getDescription());
        project.setUpdatedAt(Instant.now());

        // ذخیره تغییرات
        projectRepository.save(project);

        return mapToResponse(project);
    }

    /**
     * حذف یک پروژه
     *
     * عملیات:
     * 1. بررسی می‌کند که کاربر مالک این پروژه است
     * 2. پروژه را از دیتابیس حذف می‌کند
     *
     * @param id شناسه پروژه
     * @throws RuntimeException اگر پروژه یافت نشود یا کاربر مالک نباشد
     */
    public void delete(String id) {
        Project project = validateOwnership(id);
        projectRepository.delete(project);
    }

    /**
     * بررسی اینکه آیا کاربر فعلی مالک یک پروژه است یا نه
     *
     * عملیات:
     * 1. شناسه کاربری فعلی را دریافت می‌کند
     * 2. پروژه را در دیتابیس جستجو می‌کند
     * 3. بررسی می‌کند که userId پروژه برابر با userId فعلی است
     *
     * @param id شناسه پروژه
     * @return Project شی پروژه اگر مالکیت تأیید شود
     * @throws RuntimeException اگر پروژه یافت نشود یا کاربر مالک نباشد
     */
    private Project validateOwnership(String id) {
        String userId = getCurrentUserId();

        // جستجو برای پروژه
        Project project = projectRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Project not found"));

        // بررسی مالکیت
        if (!project.getUserId().equals(userId)) {
            throw new RuntimeException("Access denied");
        }

        return project;
    }

    /**
     * تبدیل یک شی Project به ProjectResponse
     * این متد برای تحویل داده‌های DTO به کلاینت استفاده می‌شود
     *
     * @param project شی Project
     * @return ProjectResponse
     */
    private ProjectResponse mapToResponse(Project project) {
        return ProjectResponse.builder()
                .id(project.getId())
                .name(project.getName())
                .description(project.getDescription())
                .createdAt(project.getCreatedAt())
                .updatedAt(project.getUpdatedAt())
                .build();
    }
}
