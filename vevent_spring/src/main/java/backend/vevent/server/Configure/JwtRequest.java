package backend.vevent.server.Configure;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Setter
@Getter
public class JwtRequest implements Serializable {

    private static final long serialVersionUID = 5926468583005150707L;

    private String email;
    private String Name;
    private String surName;
    private String role;
    private String photoURL;

    //need default constructor for JSON Parsing
    public JwtRequest()
    {

    }


}