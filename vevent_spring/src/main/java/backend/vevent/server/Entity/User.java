package backend.vevent.server.Entity;

//import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import javax.persistence.*;
@Getter
@Setter
@Entity
@Table(name = "users")
public class User {
    @Id
    @Column(name = "user_id", nullable = false, length = 125)
    private String userId;

    @Column(name = "username", nullable = false, length = 125)
    private String username;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "user_email", nullable = false, length = 125)
    private String userEmail;

    @Column(name = "name", nullable = false, length = 125)
    private String name;

    @Column(name = "surName", nullable = false, length = 125)
    private String surName;

    @Column(name = "profile_img", nullable = false)
    private String profileImg;

    @Lob
    @Column(name = "status", nullable = false)
    private String status;

}