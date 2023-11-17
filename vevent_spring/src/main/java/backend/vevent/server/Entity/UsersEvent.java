package backend.vevent.server.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "users_events")
public class UsersEvent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_event_id", nullable = false)
    private Integer user_event_id;

    @ManyToOne(fetch = FetchType.EAGER,optional = false,cascade = CascadeType.PERSIST)
    @JoinColumn(name = "user_id",nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.EAGER,optional = false,cascade = CascadeType.PERSIST)
    @JoinColumn(name = "event_id",nullable = false)
    private Event event;

    @Column(name = "status",nullable = false)
    private String status;


//    @EmbeddedId
//    private UsersEventId id;


}