package sit.capstone.apipoc.Controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import sit.capstone.apipoc.Entity.UsersEntity;
import sit.capstone.apipoc.Services.UserService;

import java.util.List;

@RestController
public class UseController {

    @Autowired
    private UserService service;

    @RequestMapping("/api/kw1/users")
    public List<UsersEntity> getAllUsers(){
        System.out.println("controller");
        return service.getAllUsers();
    }



}
