package backend.vevent.server.Repo;

import backend.vevent.server.Entity.UsersEvent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UserEventRepo extends JpaRepository<UsersEvent,Integer> {

    @Query(value = "SELECT * FROM users_events WHERE user_id=:uid",nativeQuery = true)
    List<UsersEvent> findAllEventByUid(@Param("uid")Integer uid);
}
