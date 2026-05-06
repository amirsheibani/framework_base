package info.amirdeveloper.form_generator_service.repository;

import info.amirdeveloper.form_generator_service.model.Form;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface FormRepository extends MongoRepository<Form, String> {

    List<Form> findByProjectIdAndUserId(String projectId, String userId);
}
