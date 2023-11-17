package backend.vevent.server.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "users")
public class User {
    @Id
    @Column(name = "user_id", nullable = false, length = 125)
    private Integer userId;

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

    @Column(name = "profile_img", nullable = false, length = 300)
    private String profileImg;



}