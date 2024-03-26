package backend.vevent.server.Validation.StepCounter;

import backend.vevent.server.Entities.Event;
import backend.vevent.server.Repo.UserEventRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class StepCounterService {

    @Autowired
    private UserEventRepo userEventRepo;

    public Map<String,Object> calculateStepCounter(Event event,double step){

        HashMap<String, Object> response = new HashMap<>();

        if(step>=event.getValidationRules()) {
            System.out.println("failed");
            response.put("Status", "Failed");
            response.put("Missing",event.getValidationRules()-step + "(Step)");
            response.put("HTTP_Status", HttpStatus.OK.value());
            System.out.println("out from status failed");
        }else{
            System.out.println("pass");
            response.put("Status", "Success");
            response.put("Missing",event.getValidationRules()-step + "(Step)");
            response.put("HTTP_Status",HttpStatus.OK.value());
        }
        return response;

    }
}
