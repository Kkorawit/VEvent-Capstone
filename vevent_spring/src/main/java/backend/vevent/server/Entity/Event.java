package backend.vevent.server.Entity;


import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "events")
public class Event {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "events_id", nullable = false)
    private Integer id;

    @Column(name = "title", nullable = false, length = 100)
    private String title;

    @Column(name = "description", nullable = false)
    private String description;

    @Column(name = "amount_received", nullable = false)
    private String amountReceived;

    @Column(name = "category", nullable = false, length = 125)
    private String category;

    @Column(name = "sub_category", nullable = false, length = 125)
    private String subCategory;

    @Column(name = "start_date", nullable = false)
    private Instant startDate;

    @Column(name = "end_date", nullable = false)
    private Instant endDate;

    @Column(name = "event_owner", length = 125)
    private String eventOwner;

    @Column(name = "register_start_date", nullable = false)
    private Instant registerStartDate;

    @Column(name = "register_end_date", nullable = false)
    private Instant registerEndDate;

    @Lob
    @Column(name = "validation_type", nullable = false)
    private String validationType;

    @Column(name = "validation_rules", nullable = false)
    private Double validationRules;

    @Column(name = "poster_img", nullable = false)
    private String posterImg;

    @Column(name = "create_by", nullable = false, length = 125)
    private String createBy;

    @Column(name = "create_date", nullable = false)
    private Instant createDate;

    @Column(name = "update_by", nullable = false, length = 125)
    private String updateBy;

    @Column(name = "update_date", nullable = false)
    private Instant updateDate;

    @Column(name = "location_name", nullable = false, length = 125)
    private String locationName;

    @Column(name = "location_latitude", nullable = false)
    private Double locationLatitude;

    @Column(name = "location_longitude", nullable = false)
    private Double locationLongitude;

}