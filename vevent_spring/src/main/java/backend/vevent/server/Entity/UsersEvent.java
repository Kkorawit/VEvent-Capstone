package backend.vevent.server.Entity;

//import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import javax.persistence.*;
@Getter
@Setter
@Entity
@Table(name = "users_events")
public class UsersEvent {
    @EmbeddedId
    private UsersEventId id;

    @MapsId("eventsId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "events_id", nullable = false)
    private Event events;

}