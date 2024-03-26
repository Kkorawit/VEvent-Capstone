package backend.vevent.server.Repo;

import backend.vevent.server.Entities.HistoryLog;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LogRepo extends JpaRepository<HistoryLog,Integer> {
}
