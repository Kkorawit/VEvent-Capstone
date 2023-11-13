package backend.vevent.server.Entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.Hibernate;

import java.io.Serializable;
import java.util.Objects;

@Getter
@Setter
@Embeddable
public class UsersEventId implements Serializable {
    private static final long serialVersionUID = -3220426123152588239L;
    @Column(name = "user_id", nullable = false, length = 125)
    private String userId;

    @Column(name = "events_id", nullable = false)
    private Integer eventsId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        UsersEventId entity = (UsersEventId) o;
        return Objects.equals(this.eventsId, entity.eventsId) &&
                Objects.equals(this.userId, entity.userId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(eventsId, userId);
    }

}