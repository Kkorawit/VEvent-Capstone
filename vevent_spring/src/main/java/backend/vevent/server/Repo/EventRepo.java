package backend.vevent.server.Repo;

import backend.vevent.server.Entities.Event;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.security.core.parameters.P;

import java.util.List;

public interface EventRepo extends JpaRepository<Event,Integer> {

    @Query(value = "SELECT * FROM users_events WHERE uid=:uid",nativeQuery = true)
    List<Event> getEventByUid(@Param("uid") Integer uid);

    @Query(value = "SELECT * FROM events WHERE event_id=:eid",nativeQuery = true)
    Event findEventById(@Param("eid")Integer eid);

    @Query(value = "SELECT * FROM events",nativeQuery = true)
    List<Event> getAllEvents();

    @Query(value = "SELECT * FROM events WHERE create_by LIKE :uEmail",nativeQuery = true)
    List<Event> findAllEventCreateByUEmail(@Param("uEmail") String uEmail);

    @Query(value = "SELECT * FROM events WHERE event_id=:eid AND create_by like :createBy",nativeQuery = true)
    Event findEventByIdAndCreateBy(@Param("eid")Integer eid, @Param("createBy")String createBy);

    @Query(value = "SELECT * FROM events WHERE category like :category",nativeQuery = true)
    List<Event> findAllEventByCategory(@Param("category")String category);


}
