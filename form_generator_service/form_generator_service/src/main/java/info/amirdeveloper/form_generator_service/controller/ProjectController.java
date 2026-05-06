package info.amirdeveloper.form_generator_service.controller;

import info.amirdeveloper.form_generator_service.dto.project.*;
import info.amirdeveloper.form_generator_service.service.ProjectService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Controller کلاس برای مدیریت درخواست‌های پروژه‌ها
 * این controller تمام عملیات CRUD پروژه‌ها را فراهم می‌کند
 * تمام endpoint‌های این controller نیاز به احراز هویت دارند
 *
 * Annotations:
 * - @RestController: مشخص می‌کند که این کلاس یک REST API controller است
 * - @RequestMapping("/api/projects"): تمام endpoint‌های این controller در محل /api/projects قرار می‌گیرند
 * - @RequiredArgsConstructor: ایجاد constructor برای dependency injection
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/projects")
public class ProjectController {

    /** Service برای مدیریت پروژه‌ها */
    private final ProjectService projectService;

    /**
     * API Endpoint برای ایجاد یک پروژه جدید
     *
     * درخواست POST (نیاز به احراز هویت):
     * URL: POST /api/projects
     * Header: Authorization: Bearer {jwt_token}
     * Body: {
     *   "name": "نام پروژه",
     *   "description": "توضیح پروژه"
     * }
     *
     * پاسخ (200 OK):
     * {
     *   "id": "507f1f77bcf86cd799439011",
     *   "name": "نام پروژه",
     *   "description": "توضیح پروژه",
     *   "createdAt": "2024-04-28T10:30:00Z",
     *   "updatedAt": "2024-04-28T10:30:00Z"
     * }
     *
     * @param request درخواست ایجاد شامل نام و توضیح پروژه
     * @return ProjectResponse شامل اطلاعات پروژه ایجاد‌شده
     */
    @PostMapping
    public ProjectResponse create(@RequestBody ProjectCreateRequest request) {
        return projectService.create(request);
    }

    /**
     * API Endpoint برای دریافت تمام پروژه‌های کاربر فعلی
     *
     * درخواست GET (نیاز به احراز هویت):
     * URL: GET /api/projects
     * Header: Authorization: Bearer {jwt_token}
     *
     * پاسخ (200 OK):
     * [
     *   {
     *     "id": "507f1f77bcf86cd799439011",
     *     "name": "پروژه 1",
     *     "description": "توضیح اول",
     *     "createdAt": "2024-04-28T10:30:00Z",
     *     "updatedAt": "2024-04-28T10:30:00Z"
     *   },
     *   ...
     * ]
     *
     * @return لیستی از ProjectResponse برای تمام پروژه‌های کاربر
     */
    @GetMapping
    public List<ProjectResponse> getAll() {
        return projectService.getAll();
    }

    /**
     * API Endpoint برای دریافت اطلاعات یک پروژه خاص
     *
     * درخواست GET (نیاز به احراز هویت):
     * URL: GET /api/projects/{id}
     * Header: Authorization: Bearer {jwt_token}
     *
     * پاسخ (200 OK):
     * {
     *   "id": "507f1f77bcf86cd799439011",
     *   "name": "نام پروژه",
     *   "description": "توضیح پروژه",
     *   "createdAt": "2024-04-28T10:30:00Z",
     *   "updatedAt": "2024-04-28T10:30:00Z"
     * }
     *
     * @param id شناسه پروژه
     * @return ProjectResponse شامل اطلاعات پروژه
     */
    @GetMapping("/{id}")
    public ProjectResponse getById(@PathVariable String id) {
        return projectService.getById(id);
    }

    /**
     * API Endpoint برای بروزرسانی یک پروژه موجود
     *
     * درخواست PUT (نیاز به احراز هویت):
     * URL: PUT /api/projects/{id}
     * Header: Authorization: Bearer {jwt_token}
     * Body: {
     *   "name": "نام جدید",
     *   "description": "توضیح جدید"
     * }
     *
     * پاسخ (200 OK):
     * {
     *   "id": "507f1f77bcf86cd799439011",
     *   "name": "نام جدید",
     *   "description": "توضیح جدید",
     *   "createdAt": "2024-04-28T10:30:00Z",
     *   "updatedAt": "2024-04-28T11:45:00Z"
     * }
     *
     * @param id شناسه پروژه
     * @param request درخواست بروزرسانی شامل نام و توضیح جدید
     * @return ProjectResponse شامل اطلاعات پروژه بروزرسانی‌شده
     */
    @PutMapping("/{id}")
    public ProjectResponse update(
            @PathVariable String id,
            @RequestBody ProjectUpdateRequest request
    ) {
        return projectService.update(id, request);
    }

    /**
     * API Endpoint برای حذف یک پروژه
     *
     * درخواست DELETE (نیاز به احراز هویت):
     * URL: DELETE /api/projects/{id}
     * Header: Authorization: Bearer {jwt_token}
     *
     * پاسخ (204 No Content):
     * بدون بدنه
     *
     * @param id شناسه پروژه
     */
    @DeleteMapping("/{id}")
    public void delete(@PathVariable String id) {
        projectService.delete(id);
    }
}
