package info.amirdeveloper.form_generator_service.service;

import info.amirdeveloper.form_generator_service.dto.form.*;
import info.amirdeveloper.form_generator_service.model.Form;
import info.amirdeveloper.form_generator_service.model.Project;
import info.amirdeveloper.form_generator_service.repository.FormRepository;
import info.amirdeveloper.form_generator_service.repository.ProjectRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.List;

@Service
@RequiredArgsConstructor
public class FormService {

    private final FormRepository formRepository;
    private final ProjectRepository projectRepository;

    private String getCurrentUserId() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        return auth.getName();
    }

    // Validate user owns the project
    private Project validateProjectOwnership(String projectId) {
        String userId = getCurrentUserId();

        Project project = projectRepository.findById(projectId)
                .orElseThrow(() -> new RuntimeException("Project not found"));

        if (!project.getUserId().equals(userId)) {
            throw new RuntimeException("Access denied");
        }

        return project;
    }

    private FormResponse mapToResponse(Form form) {
        return FormResponse.builder()
                .id(form.getId())
                .projectId(form.getProjectId())
                .title(form.getTitle())
                .description(form.getDescription())
                .createdAt(form.getCreatedAt())
                .updatedAt(form.getUpdatedAt())
                .build();
    }

    public FormResponse create(String projectId, FormCreateRequest request) {

        validateProjectOwnership(projectId);

        String userId = getCurrentUserId();

        Form form = Form.builder()
                .projectId(projectId)
                .userId(userId)
                .title(request.getTitle())
                .description(request.getDescription())
                .createdAt(Instant.now())
                .updatedAt(Instant.now())
                .build();

        formRepository.save(form);

        return mapToResponse(form);
    }

    public List<FormResponse> getAll(String projectId) {

        validateProjectOwnership(projectId);
        String userId = getCurrentUserId();

        return formRepository.findByProjectIdAndUserId(projectId, userId)
                .stream()
                .map(this::mapToResponse)
                .toList();
    }

    public FormResponse getById(String projectId, String formId) {

        validateProjectOwnership(projectId);
        String userId = getCurrentUserId();

        Form form = formRepository.findById(formId)
                .orElseThrow(() -> new RuntimeException("Form not found"));

        if (!form.getProjectId().equals(projectId) || !form.getUserId().equals(userId)) {
            throw new RuntimeException("Access denied");
        }

        return mapToResponse(form);
    }

    public FormResponse update(String projectId, String formId, FormUpdateRequest request) {

        validateProjectOwnership(projectId);
        String userId = getCurrentUserId();

        Form form = formRepository.findById(formId)
                .orElseThrow(() -> new RuntimeException("Form not found"));

        if (!form.getProjectId().equals(projectId) || !form.getUserId().equals(userId)) {
            throw new RuntimeException("Access denied");
        }

        form.setTitle(request.getTitle());
        form.setDescription(request.getDescription());
        form.setUpdatedAt(Instant.now());

        formRepository.save(form);

        return mapToResponse(form);
    }

    public void delete(String projectId, String formId) {

        validateProjectOwnership(projectId);
        String userId = getCurrentUserId();

        Form form = formRepository.findById(formId)
                .orElseThrow(() -> new RuntimeException("Form not found"));

        if (!form.getProjectId().equals(projectId) || !form.getUserId().equals(userId)) {
            throw new RuntimeException("Access denied");
        }

        formRepository.delete(form);
    }
}
