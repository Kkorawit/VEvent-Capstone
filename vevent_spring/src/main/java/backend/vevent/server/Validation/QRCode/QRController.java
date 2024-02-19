package backend.vevent.server.Validation.QRCode;


import backend.vevent.server.Entity.Event;
import backend.vevent.server.Entity.UsersEvent;
import backend.vevent.server.Repo.EventRepo;
import backend.vevent.server.Repo.UserEventRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.Optional;

@RestController
@RequestMapping("/api")
public class QRController {


    @Autowired
    private QRService qrService;

    @Autowired
    private UserEventRepo userEventRepo;

    @Autowired
    private EventRepo eventRepo;

    @PostMapping("/qrcode")
    public ResponseEntity validateQRCode(@RequestParam(value = "ueid")Integer ueid,
                                         @RequestParam(value = "QRstart")Instant qrstart,
                                         @RequestParam(value = "duration",defaultValue = "5")Integer duration,
                                         @RequestParam(value = "currentDateTime",defaultValue = "null")Instant currentDateTime,
                                         @RequestParam(name = "lat",value = "lat",required = false)Long lat,
                                         @RequestParam(name = "long",value = "long",required = false)Long lng){

        UsersEvent usersEvent = userEventRepo.findUsersEventById(ueid);
        boolean isInTime = qrService.QrTimeCheck(qrstart,duration,currentDateTime);
        System.out.println(isInTime);
//        String EventTimeStatus = qrService.EventTimeCheck(ueid, qrstart,duration);
        if(usersEvent != null){
            Event event = eventRepo.findEventById(usersEvent.getEvent().getId());
            System.out.println("In first condition");
            if(usersEvent.getStatus().equals("IP") || usersEvent.getStatus().equals("F") && event.getEventStatus().equals("ON")) {
                System.out.println("In second condition");
                if (isInTime) {
                    System.out.println("validate success");
                    usersEvent.setStatus("S");
                    userEventRepo.save(usersEvent);
                    return ResponseEntity.ok().body("Validate Success");
                } else {
                    System.out.println("validate failed");
                    usersEvent.setStatus("F");
                    userEventRepo.save(usersEvent);
                    return ResponseEntity.badRequest().body("Validate Failed: This QRCode is Expired");
                }
            }else{
                System.out.println("can't validate");
                return ResponseEntity.badRequest().body("Can't Validate This Event Now");
            }
        }
        System.out.println("Not found");
        return ResponseEntity.notFound().build();
    }
}
