package info.amirdeveloper.form_generator_service.dto.form;

import lombok.Builder;
import lombok.Data;

import java.time.Instant;

@Data
@Builder
public class FormResponse {

    private String id;
    private String projectId;

    private String title;
    private String description;

    private Instant createdAt;
    private Instant updatedAt;
}
