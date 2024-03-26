package backend.vevent.server.Entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "history_log")
public class HistoryLog {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "history_log_id", nullable = false)
    private Integer id;

    @Lob
    @Column(name = "section", nullable = false)
    private String section;

    @Lob
    @Column(name = "state", nullable = false)
    private String state;

    @Column(name = "details", nullable = false, length = 150)
    private String details;

    @Column(name = "create_date",columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    @Transient
    private Instant createDate;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_email", nullable = false, referencedColumnName = "user_email")
    private User userEmail;

    @Column(name = "event_id",nullable = false)
    private Integer eventId;

}