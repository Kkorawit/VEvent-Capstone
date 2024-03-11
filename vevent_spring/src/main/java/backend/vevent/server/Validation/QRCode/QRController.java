package backend.vevent.server.Validation.QRCode;


import backend.vevent.server.Entity.Event;
import backend.vevent.server.Entity.UsersEvent;
import backend.vevent.server.Repo.EventRepo;
import backend.vevent.server.Repo.UserEventRepo;
import backend.vevent.server.Validation.GPS.GPSController;
import backend.vevent.server.Validation.GPS.GPSService;
import backend.vevent.server.Validation.GPS.LatLngDTO;
import backend.vevent.server.Validation.ValidateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;


import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

@RestController
@RequestMapping("/api")
public class QRController {


    @Autowired
    private QRService qrService;

    @Autowired
    private UserEventRepo userEventRepo;

    @Autowired
    private EventRepo eventRepo;

    @Autowired
    private GPSService gpsService;

    @Autowired
    private ValidateService validateService;

    @PostMapping("/qrcode")
    public ResponseEntity validateQRCode(
            @RequestParam(value = "ueid")Integer ueid,
            @RequestParam(value = "QRstart")Instant qrstart,
            @RequestParam(value = "duration",defaultValue = "5")Integer duration,
            @RequestParam(value = "currentDateTime",defaultValue = "null")Instant currentDateTime,
            @RequestParam(name = "lat",value = "lat",required = false,defaultValue = "0")double lat,
            @RequestParam(name = "long",value = "long",required = false,defaultValue = "0")double lng,
            Authentication authentication){
        UsersEvent usersEvent = userEventRepo.findUsersEventById(ueid);

        String response;




        boolean isInTime = qrService.QrTimeCheck(qrstart,duration,currentDateTime);
        System.out.println(isInTime);
//        String EventTimeStatus = qrService.EventTimeCheck(ueid, qrstart,duration);
        if(usersEvent != null){
            Event event = eventRepo.findEventById(usersEvent.getEvent().getId());
            Map<String,String> resultEventCheck = validateService.checkEventProcessing(event.getId());
            Map<String,String> resultValidateCheck = validateService.checkValidateProcessing(usersEvent.getUser_event_id());
            System.out.println("In first condition");
            if(resultValidateCheck.get("status").equals("OK")&&resultEventCheck.get("status").equals("OK")){
                if (isInTime) {
                    boolean displacementSuccess = false;
                    if(lat!=0&lng!=0) {
                        System.out.println("what?");
                        LatLngDTO latLngDTO = new LatLngDTO();
                        latLngDTO.setFlat(lat);
                        latLngDTO.setFlong(lng);
                        double haversine = gpsService.calHaversine(latLngDTO,usersEvent.getEvent().getId());
                        HashMap<String, Object> displacement = gpsService.calDisplacementWithHaversine(haversine);
                        String displacementStatus = Objects.requireNonNull(displacement.get("VStatus")).toString();
//            int begin = resultStatus.indexOf("VStatus=")+8;
//            int end = resultStatus.indexOf(",");
//            resultStatus = resultStatus.substring(begin,end);


                        System.out.println("here: "+ displacementStatus);
                        if(displacementStatus.equals("Success")){
                            usersEvent.setStatus("S");
                            userEventRepo.save(usersEvent);
                            return ResponseEntity.ok().body("Success");
                        }
                    }
                    response = "Success";
                    System.out.println("Success");
                    usersEvent.setStatus("S");
                    userEventRepo.save(usersEvent);


                } else {
                    System.out.println("validate failed");
                    usersEvent.setStatus("F");
                    userEventRepo.save(usersEvent);
                    response = "QR code was expired";
//
                }
            } else if (resultValidateCheck.get("status").equals("Deny")) {
                return ResponseEntity.badRequest().body("Can't Validate This Event");
            } else {
                return ResponseEntity.badRequest().body(resultEventCheck.get("resultText"));
            }
            return ResponseEntity.ok().body(response);
        }
        System.out.println("Not found");
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Not Found Event");
    }

//    public String validateQRCodeWithLocation(){
//
//
//    }


}
