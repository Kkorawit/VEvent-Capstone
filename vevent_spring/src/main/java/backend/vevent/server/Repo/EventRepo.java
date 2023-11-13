package backend.vevent.server.Repo;

import backend.vevent.server.Entity.Event;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface EventRepo extends JpaRepository<Event,Integer> {

    @Query(value = "SELECT * FROM users_events WHERE uid=:uid",nativeQuery = true)
    public List<Event> getEventByUid(@Param("uid") Integer uid);
}
