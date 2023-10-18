package sit.capstone.apipoc.Repo;

import org.springframework.data.jpa.repository.Query;
import sit.capstone.apipoc.Entity.UsersEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepo extends JpaRepository<UsersEntity,Integer>{

    @Query(value = "SELECT * FROM users",nativeQuery = true)
    public List<UsersEntity> findAll();
}
