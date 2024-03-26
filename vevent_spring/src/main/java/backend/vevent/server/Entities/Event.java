package backend.vevent.server.Entities;

import jakarta.persistence.*;

import lombok.Getter;
import lombok.Setter;
import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "events")
public class Event {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "event_id", nullable = false)
    private Integer id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "description", nullable = false)

    private String description;
    @Column(name = "amount_received", nullable = false)
    private String amountReceived;

    @Column(name = "category", nullable = false, length = 125)
    private String category;

    @Column(name = "sub_category", nullable = false, length = 125)
    private String subCategory;

    @Column(name = "start_date",columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    @Transient
    private Instant startDate;

    @Column(name = "end_date")
    private Instant endDate;

    @Column(name = "register_start_date",columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    @Transient
    private Instant registerStartDate;

    @Column(name = "register_end_date")
    private Instant registerEndDate;

    @Lob
    @Column(name = "validation_type", nullable = false)
    private String validationType;

    @Column(name = "validation_rules", nullable = false)
    private Double validationRules;

    @Column(name = "poster_img", nullable = false, length = 300)
    private String posterImg;

    @Column(name = "create_by", nullable = false, length = 125)
    private String createBy;

    @Column(name = "create_date",columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    @Transient
    private Instant createDate;

    @Column(name = "update_by", nullable = false, length = 125)
    private String updateBy;

    @Column(name = "update_date",columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    @Transient
    private Instant updateDate;

    @Column(name = "location_name", nullable = false, length = 300)
    private String locationName;

    @Column(name = "location_latitude")
    private Double locationLatitude;

    @Column(name = "location_longitude")
    private Double locationLongitude;

    @Lob
    @Column(name = "event_status", nullable = false)
    private String eventStatus;

}