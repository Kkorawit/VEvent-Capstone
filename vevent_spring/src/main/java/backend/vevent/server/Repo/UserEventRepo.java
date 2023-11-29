package backend.vevent.server.Repo;

import backend.vevent.server.Entity.UsersEvent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UserEventRepo extends JpaRepository<UsersEvent,Integer> {

    @Query(value = "SELECT * FROM users_events WHERE user_email=:uEmail",nativeQuery = true)
    List<UsersEvent> findAllEventByUEmail(@Param("uEmail")String uEmail);
}
