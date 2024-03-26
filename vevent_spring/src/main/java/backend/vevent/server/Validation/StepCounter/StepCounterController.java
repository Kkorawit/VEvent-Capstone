package backend.vevent.server.Validation.StepCounter;

import backend.vevent.server.Entities.Event;
import backend.vevent.server.Entities.UsersEvent;
import backend.vevent.server.Repo.UserEventRepo;
import backend.vevent.server.Service.LogService;
import backend.vevent.server.Validation.LogSection;
import backend.vevent.server.Validation.LogState;
import backend.vevent.server.Validation.ValidateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class StepCounterController {

    @Autowired
    private UserEventRepo userEventRepo;

    @Autowired
    private ValidateService validateService;

    @Autowired
    private StepCounterService stepCounterService;

    @Autowired
    private LogService logService;

    @PostMapping("/step-counter")
    public ResponseEntity validateStepCounter(@RequestParam(value = "step")double step,
                                        @RequestParam(value = "ueid")Integer ueid,
                                        Authentication authentication){

        UsersEvent usersEvent = userEventRepo.findUsersEventById(ueid);
        Event event = usersEvent.getEvent();

        Map<String,String> resultEventCheck = validateService.checkEventProcessing(event.getId());
        Map<String,String> resultValidateCheck = validateService.checkValidateProcessing(usersEvent.getUser_event_id());
        Map<String,Object> resultStepCheck = stepCounterService.calculateStepCounter(event,step);

        if(resultValidateCheck.get("Status").equals("OK")&&resultEventCheck.get("Status").equals("OK")){

            if(step>=event.getValidationRules()){
                System.out.println("In Step Validate Pass");
                usersEvent.setStatus("S");
                userEventRepo.saveAndFlush(usersEvent);
                logService.saveAndFlushLog(LogSection.VALIDATE, LogState.STEP_COUNTER,"Validate event " + usersEvent.getEvent().getTitle() + " success", usersEvent.getUser(), event.getId());
                return ResponseEntity.ok().body("Success");
            }else {
                System.out.println("In Step Validate Failed");
                usersEvent.setStatus("F");
                userEventRepo.saveAndFlush(usersEvent);
                logService.saveAndFlushLog(LogSection.VALIDATE, LogState.STEP_COUNTER,"Validate event " + usersEvent.getEvent().getTitle() + " failed", usersEvent.getUser(), event.getId());
                return ResponseEntity.ok().body("Validate Failed");
            }
        } else if (resultValidateCheck.get("status").equals("Deny")) {
            return ResponseEntity.badRequest().body("Can't Validate This Event");
        } else {
            return ResponseEntity.badRequest().body(resultEventCheck.get("resultText"));
        }
    }
}
