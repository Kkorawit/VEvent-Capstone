package backend.vevent.server.Repo;

import backend.vevent.server.Entity.UsersEvent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface UserEventRepo extends JpaRepository<UsersEvent,Integer> {

    @Query(value = "SELECT * FROM users_events WHERE user_email LIKE :uEmail",nativeQuery = true)
    List<UsersEvent> findAllRegisEventByUEmail(@Param("uEmail")String uEmail);

    @Query(value = "SELECT * FROM users_events WHERE user_email LIKE :uEmail and event_id = :eid",nativeQuery = true)
    UsersEvent findByEmailAndId(@Param("uEmail")String uEmail,@Param("eid")Integer eid);

    @Query(value = "SELECT DISTINCT * FROM users_events ue WHERE ue.event_id = :eid",nativeQuery = true)
    List<UsersEvent> findAllUserByEid(@Param("eid")Integer eid);

    @Query(value = "SELECT * FROM users_events WHERE user_event_id=:id",nativeQuery = true)
    Optional<UsersEvent> findUsersEventById(@Param("id")Integer id);
}
