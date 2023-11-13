package sit.capstone.apipoc.Services;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;
import sit.capstone.apipoc.Entity.UsersEntity;
import sit.capstone.apipoc.Repo.UserRepo;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserRepo userRepo;


    public List<UsersEntity> getAllUsers() {
        System.out.println("service");
        List<UsersEntity> users = userRepo.findAll();

        System.out.println(users);
        return users;


    }
}
