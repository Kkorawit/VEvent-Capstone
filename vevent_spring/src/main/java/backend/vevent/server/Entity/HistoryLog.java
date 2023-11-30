package backend.vevent.server.Entity;

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

    @Column(name = "section", nullable = false, length = 100)
    private String section;

    @Column(name = "state", nullable = false, length = 100)
    private String state;

    @Column(name = "details", nullable = false, length = 150)
    private String details;

    @Column(name = "create_date", nullable = false)
    private Instant createDate;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_email", nullable = false, referencedColumnName = "user_email")
    private User user;

}