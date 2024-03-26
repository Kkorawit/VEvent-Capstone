package backend.vevent.server.Service;

import backend.vevent.server.Entities.HistoryLog;
import backend.vevent.server.Entities.User;
import backend.vevent.server.Repo.LogRepo;
import backend.vevent.server.Repo.UserRepo;
import backend.vevent.server.Validation.LogSection;
import backend.vevent.server.Validation.LogState;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LogService {

    @Autowired
    private LogRepo logRepo;

    @Autowired
    private UserRepo userRepo;

    public void saveAndFlushLog(LogSection section, LogState state, String details, User user, Integer eventId)throws ClassCastException {
        HistoryLog newLog = new HistoryLog();
        newLog.setSection(String.valueOf(section));
        newLog.setState(String.valueOf(state));
        newLog.setDetails(details);
        newLog.setUserEmail(user);
        newLog.setEventId(eventId);

//        saveHistoryLog(newLog,user.getUserEmail());
        logRepo.saveAndFlush(newLog);
    }

//    public void saveHistoryLog(HistoryLog historyLog, String userEmail) {
//        // Retrieve the user from the database
//        User user = userRepo.findUserByEmail(userEmail);
//
//        if (user != null) {
//            // Set the user for the history log
//            historyLog.setUser(user);
//            // Save the history log
//            logRepo.save(historyLog);
//        } else {
//            // Handle case when user is not found
//        }
//    }

}
