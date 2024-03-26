package backend.vevent.server.Controller;

import backend.vevent.server.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin("*")
@RequestMapping("/api")
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("/createAcc")
    public ResponseEntity createNewAccount(){

        return ResponseEntity.ok().body("");
    }


}
