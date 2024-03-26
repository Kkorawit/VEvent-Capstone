package backend.vevent.server.Validation;

import backend.vevent.server.Entities.Event;
import backend.vevent.server.Entities.User;
import backend.vevent.server.Repo.EventRepo;
import backend.vevent.server.Repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.Map;

@Service
public class AuthorizationService {

    @Autowired
    private UserRepo userRepo;
    @Autowired
    private EventRepo eventRepo;

    public Map<String, String> mapAuthenticated(Authentication authentication){
        Map<String,String> mappedAuthentication = new HashMap<>();

        if (authentication==null){
            throw new UsernameNotFoundException("Must be Signed In");
        }else{
            mappedAuthentication.put("role",String.valueOf(authentication.getAuthorities().toArray()[0]));
            mappedAuthentication.put("userEmail",authentication.getName());
            return mappedAuthentication;
        }
    }

    public boolean authorizeCheck(Authentication authentication){
        Map<String,String> mappedAuthenticated = mapAuthenticated(authentication);
        if(mappedAuthenticated.isEmpty()){
            return false;
        }
        User signedInUser = userRepo.findUserByEmail(mappedAuthenticated.get("userEmail"));

        switch (signedInUser.getRole()){
            default: case "Organization":
                return true;
            case "Participants":
                return false;
        }
    }

    public boolean authenCheck(Authentication authentication,Event event){
        boolean authorize = authorizeCheck(authentication);

        Event ownEvent = eventRepo.findEventByIdAndCreateBy(event.getId(),authentication.getName());

        if(authorize&&ownEvent!=null){
            return true;
        }else {
            return false;
        }

    }

    public boolean editDeleteAccess(Instant currentDT, Event event){
        return currentDT.plus(3, ChronoUnit.DAYS).isBefore(event.getRegisterStartDate())&&
                currentDT.plus(3, ChronoUnit.DAYS).isBefore(event.getStartDate());
    }

}
