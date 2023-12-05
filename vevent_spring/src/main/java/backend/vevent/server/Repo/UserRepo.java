package backend.vevent.server.Repo;

import backend.vevent.server.Entity.User;
import backend.vevent.server.Entity.UsersEvent;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface UserRepo {

    @Query(value = "SELECT * FROM users WHERE user_email=:uEmail",nativeQuery = true)
    User findUserByEmail(@Param("uEmail")String uEmail);
}
