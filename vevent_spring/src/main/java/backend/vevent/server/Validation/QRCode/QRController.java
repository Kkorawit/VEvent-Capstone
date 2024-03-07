package backend.vevent.server.Validation.QRCode;


import backend.vevent.server.Configure.EntityResponse;
import backend.vevent.server.Entity.Event;
import backend.vevent.server.Entity.UsersEvent;
import backend.vevent.server.Repo.EventRepo;
import backend.vevent.server.Repo.UserEventRepo;
import backend.vevent.server.Validation.GPS.GPSController;
import backend.vevent.server.Validation.GPS.LatLngDTO;
import org.apache.coyote.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.HashMap;
import java.util.Objects;
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

    @Autowired
    private GPSController gpsController;

    @PostMapping("/qrcode")
    public ResponseEntity validateQRCode(
                                         @RequestParam(value = "ueid")Integer ueid,
                                         @RequestParam(value = "QRstart")Instant qrstart,
                                         @RequestParam(value = "duration",defaultValue = "5")Integer duration,
                                         @RequestParam(value = "currentDateTime",defaultValue = "null")Instant currentDateTime,
                                         @RequestParam(name = "lat",value = "lat",required = false,defaultValue = "0")double lat,
                                         @RequestParam(name = "long",value = "long",required = false,defaultValue = "0")double lng){
        UsersEvent usersEvent = userEventRepo.findUsersEventById(ueid);
        HashMap<String, Object> response = new HashMap<>();

        if(lat!=0&lng!=0) {
            System.out.println("what?");
            LatLngDTO latLngDTO = new LatLngDTO();
            latLngDTO.setFlat(lat);
            latLngDTO.setFlong(lng);
            ResponseEntity<Object> resultGPS = gpsController.findDisplacement(latLngDTO,usersEvent.getEvent().getId(),usersEvent.getUser().getUserEmail());
            String resultStatus = Objects.requireNonNull(resultGPS.getBody()).toString();
            int begin = resultStatus.indexOf("VStatus=")+8;
            int end = resultStatus.indexOf(",");
            resultStatus = resultStatus.substring(begin,end);
            response.put("VStatus",resultStatus);

            System.out.println("here: "+ response);
        }


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
                    response.put("VStatus_qr","Validate Success");
                    response.put("Http_Status",HttpStatus.OK.value());
//                    return ResponseEntity.ok().body("Validate Success");
                } else {
                    System.out.println("validate failed");
                    usersEvent.setStatus("F");
                    userEventRepo.save(usersEvent);
                    response.put("VStatus_qr","Validate Failed: This QRCode is Expired");
                    response.put("Http_Status",HttpStatus.BAD_REQUEST.value());
//                    return ResponseEntity.badRequest().body("Validate Failed: This QRCode is Expired");
                }
            }else{
                System.out.println("can't validate");
//                response.put("VStatus_qr","Can't Validate This Event");
//                response.put("Http_Status",HttpStatus.BAD_REQUEST.value());
                return ResponseEntity.badRequest().body("Can't Validate This Event Now");
            }
            return ResponseEntity.ok().body(response);
        }
        System.out.println("Not found");
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
    }


}
