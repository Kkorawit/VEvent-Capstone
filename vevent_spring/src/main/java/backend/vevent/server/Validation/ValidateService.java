package backend.vevent.server.Validation;


import backend.vevent.server.Entity.Event;
import backend.vevent.server.Entity.UsersEvent;
import backend.vevent.server.Repo.EventRepo;
import backend.vevent.server.Repo.UserEventRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class ValidateService {

    @Autowired
    private EventRepo eventRepo;
    @Autowired
    private UserEventRepo userEventRepo;


    public Map<String,String> checkEventProcessing(Integer eid){

        Event event = eventRepo.findEventById(eid);
        String eventStatus = event.getEventStatus();
        Map<String,String> result = new HashMap<>();

        switch (eventStatus){
            case "UP":
                result.put("resultText","Event wasn't start yet");
                result.put("status","Deny");
                break;

            case "ON":
                result.put("resultText","Event is ongoing");
                result.put("status","OK");
                break;

            case "CO":
                result.put("resultText","Event is closed");
                result.put("status","Deny");
                break;

            case "CA":
                result.put("resultText","Event is canceled");
                result.put("status","Deny");
                break;
        }
        return result;
    }

    public Map<String,String> checkValidateProcessing(Integer ueid){
        UsersEvent usersEvent = userEventRepo.findUsersEventById(ueid);
        String validateStatus = usersEvent.getStatus();
        Map<String,String> result = new HashMap<>();

        switch (validateStatus){
            case "P":
            case "S":
                result.put("resultText","Can't Validate");
                result.put("status","Deny");
                break;
            case "IP":
            case "F":
                result.put("resultText","Can Validate Now");
                result.put("status","OK");
                break;
            default:
                result.put("resultText","Something Wrong");
                result.put("status","Need Fix");
        }
    return result;
    }


}
