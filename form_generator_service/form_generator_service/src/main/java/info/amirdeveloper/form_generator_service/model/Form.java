package info.amirdeveloper.form_generator_service.model;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.Instant;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "forms")
public class Form {

    @Id
    private String id;

    private String projectId;
    private String userId;     // برای امنیت مهم است

    private String title;
    private String description;

    private Instant createdAt;
    private Instant updatedAt;
}
