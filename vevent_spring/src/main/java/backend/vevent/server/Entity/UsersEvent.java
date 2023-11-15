package backend.vevent.server.Entity;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "users_events")
public class UsersEvent {
    @EmbeddedId
    private UsersEventId id;

    //TODO [JPA Buddy] generate columns from DB
}