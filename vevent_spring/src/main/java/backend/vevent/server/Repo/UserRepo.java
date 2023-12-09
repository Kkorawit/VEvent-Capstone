package backend.vevent.server.Repo;

import backend.vevent.server.Entity.Event;
import backend.vevent.server.Entity.User;
import backend.vevent.server.Entity.UsersEvent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface UserRepo extends JpaRepository<User,Integer> {

    @Query(value = "SELECT * FROM users WHERE user_email LIKE :uEmail",nativeQuery = true)
    Optional<User> findUserByEmail(@Param("uEmail")String uEmail);

}
