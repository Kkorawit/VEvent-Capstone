package backend.vevent.server.Repo;

import backend.vevent.server.Entity.Event;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface EventRepo extends JpaRepository<Event,Integer> {

    @Query(value = "SELECT * FROM users_events WHERE uid=:uid",nativeQuery = true)
    public List<Event> getEventByUid(@Param("uid") Integer uid);

    @Query(value = "SELECT * FROM events WHERE event_id=:eid",nativeQuery = true)
    public Optional<Event> findById(@Param("eid")Integer eid);

    @Query(value = "SELECT * FROM events",nativeQuery = true)
    List<Event> getAllEvents();

    @Query(value = "SELECT * FROM events WHERE create_by LIKE :uEmail",nativeQuery = true)
    List<Event> findAllEventCreateByUEmail(@Param("uEmail") String uEmail);


//    @Query(value = "SELECT * FROM users_events WHERE user_id=:uid",nativeQuery = true)
//    List<Event> findAllEventByUid(@Param("uid")Integer uid);

}
