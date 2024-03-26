package backend.vevent.server.Controller;


import backend.vevent.server.Entities.Event;
import backend.vevent.server.Repo.EventRepo;
import backend.vevent.server.Service.EventService;
import backend.vevent.server.Validation.AuthorizationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.time.Instant;
import java.time.temporal.ChronoUnit;

@RestController
@RequestMapping("/api")
public class EventController {

    @Autowired
    private EventService eventService;

    @Autowired
    private EventRepo eventRepo;

    @Autowired
    private AuthorizationService authorizationService;

    @PostMapping("/book-event")
    public ResponseEntity createEvent(@RequestBody Event event,
                                      @RequestParam(value = "currentDT") Instant currentDT,
                                      Authentication authentication) {
        if(currentDT.plus(3, ChronoUnit.DAYS).isBefore(event.getRegisterStartDate())&&currentDT.plus(3, ChronoUnit.DAYS).isBefore(event.getStartDate())){
            return eventService.createEvent(event,authentication);
        }else{
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Event Start Date and Register Start Date Must be Next 3 Days later "+currentDT);
        }



    }


    @DeleteMapping("/delete-event")
    public ResponseEntity deleteEvent(@RequestParam(value = "eid")Integer eid,
                                      @RequestParam(value = "currentDT") Instant currentDT,
                                      Authentication authentication) throws IOException {
        Event event = eventRepo.findEventById(eid);

        boolean isAuthorize = authorizationService.authorizeCheck(authentication);
        boolean dateTimeAccess = authorizationService.editDeleteAccess(currentDT,event);
        boolean isAuthen = authorizationService.authenCheck(authentication,event);
        if(dateTimeAccess){
            if(isAuthen&&isAuthorize){
                return eventService.deleteEvent(event);
            }else{
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("You Don't Have Permission");
            }
        }else{
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Event Start Date and Register Start Date Must be Next 3 Days later "+currentDT);
        }

    }

    @PutMapping("/edit-event")
    public ResponseEntity editEvent(@RequestBody Event event,
                                    @RequestParam(value = "currentDT") Instant currentDT,
                                    Authentication authentication){

        boolean isAuthorize = authorizationService.authorizeCheck(authentication);
        boolean dateTimeAccess = authorizationService.editDeleteAccess(currentDT,event);
        boolean isAuthen = authorizationService.authenCheck(authentication,event);

        if(dateTimeAccess){
            if(isAuthen&&isAuthorize){
                return eventService.editEvent(event,authentication);
            }else{
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("You Don't Have Permission");
            }
        }else{
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Event Start Date and Register Start Date Must be Next 3 Days later "+currentDT);
        }
    }

}
