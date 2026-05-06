package info.amirdeveloper.form_generator_service.dto.form;

import lombok.Data;

@Data
public class FormCreateRequest {
    private String title;
    private String description;
}
