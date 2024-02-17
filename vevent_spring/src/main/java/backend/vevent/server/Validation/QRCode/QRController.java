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
        String EventTimeStatus = qrService.EventTimeCheck(ueid, qrstart,duration);
        if(usersEvent != null && EventTimeStatus.equals("During the Activity")){
            Event event = eventRepo.findEventById(usersEvent.getEvent().getId());

            if(usersEvent.getStatus().equals("IP") && event.getEventStatus().equals("ON")) {

                if (isInTime) {
                    usersEvent.setStatus("S");
                    userEventRepo.save(usersEvent);
                    return ResponseEntity.ok().body("Validate Success");
                } else {
                    usersEvent.setStatus("F");
                    userEventRepo.save(usersEvent);
                    return ResponseEntity.badRequest().body("Validate Failed: This QRCode is Expired");
                }
            }else{
                return ResponseEntity.badRequest().body("Can't Validate This Event Now");
            }
        }
        return ResponseEntity.notFound().build();
    }
}
