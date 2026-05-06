package info.amirdeveloper.form_generator_service.controller;

import info.amirdeveloper.form_generator_service.dto.form.*;
import info.amirdeveloper.form_generator_service.service.FormService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/projects/{projectId}/forms")
public class FormController {

    private final FormService formService;

    @PostMapping
    public FormResponse create(
            @PathVariable String projectId,
            @RequestBody FormCreateRequest request
    ) {
        return formService.create(projectId, request);
    }

    @GetMapping
    public List<FormResponse> getAll(@PathVariable String projectId) {
        return formService.getAll(projectId);
    }

    @GetMapping("/{formId}")
    public FormResponse getById(
            @PathVariable String projectId,
            @PathVariable String formId
    ) {
        return formService.getById(projectId, formId);
    }

    @PutMapping("/{formId}")
    public FormResponse update(
            @PathVariable String projectId,
            @PathVariable String formId,
            @RequestBody FormUpdateRequest request
    ) {
        return formService.update(projectId, formId, request);
    }

    @DeleteMapping("/{formId}")
    public void delete(
            @PathVariable String projectId,
            @PathVariable String formId
    ) {
        formService.delete(projectId, formId);
    }
}
