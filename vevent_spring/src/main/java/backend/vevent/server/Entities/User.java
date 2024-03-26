package backend.vevent.server.Entities;

import jakarta.persistence.*;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "users")
public class User {

    @Id
    @Column(name = "user_email", nullable = false, length = 125)
    private String userEmail;

    @Column(name = "display_name",nullable = false,length = 125)
    private String displayName;

    @Column(name = "profile_img", nullable = false, length = 300)
    private String profileImg;

    @Lob
    @Column(name = "role", nullable = false)
    private String role;

}