package backend.vevent.server.Service;

import backend.vevent.server.Entities.User;
import backend.vevent.server.Repo.UserEventRepo;
import backend.vevent.server.Repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private LogService logService;

    @Autowired
    private UserEventRepo userEventRepo;
    public boolean createAccount(String email, String displayName, String role, String profileImg) throws Exception {

        User duplicateEmail = userRepo.findUserByEmail(email);
        User newUser = new User();

//        if (duplicateEmail == null){
//            try {
//                newUser.setUserEmail(email);
//                newUser.setDisplayName(displayName);
//                newUser.setRole(role);
//                newUser.setProfileImg(profileImg);
//                userRepo.saveAndFlush(newUser);
//                return true;
//            } catch (Exception exception){
//                throw new Exception(exception);
//            }
//        }
        return false;
    }


}
