package backend.vevent.server.Repo;

import backend.vevent.server.Entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserRepo extends JpaRepository<User,Integer> {

    @Query(value = "SELECT * FROM users WHERE user_email LIKE :uEmail",nativeQuery = true)
    User findUserByEmail(@Param("uEmail")String uEmail);

    @Query(value = "SELECT * FROM users WHERE user_email LIKE :uEmail AND role = 'Participants'",nativeQuery = true)
    User findAllParticipantsByEmail(@Param("uEmail")String uEmail);

    @Query(value = "DELETE FROM users WHERE user_email LIKE :uEmail",nativeQuery = true)
    void deleteByUserEmail(@Param("uEmail")String uEmail);
}
