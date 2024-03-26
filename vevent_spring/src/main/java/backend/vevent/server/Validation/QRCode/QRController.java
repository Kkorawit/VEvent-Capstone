package backend.vevent.server.Validation.QRCode;


import backend.vevent.server.Entities.Event;
import backend.vevent.server.Entities.UsersEvent;
import backend.vevent.server.Repo.EventRepo;
import backend.vevent.server.Repo.UserEventRepo;
import backend.vevent.server.Service.LogService;
import backend.vevent.server.Validation.GPS.GPSService;
import backend.vevent.server.Validation.GPS.LatLngDTO;
import backend.vevent.server.Validation.LogSection;
import backend.vevent.server.Validation.LogState;
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
import java.util.Base64;
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

    @Autowired
    private LogService logService;
    @PostMapping("/qrcode")
    public ResponseEntity validateQRCode(
//                @RequestParam(value = "qrInfo")String qrInfo,
            @RequestParam(value = "ueid")Integer ueid,
            @RequestParam(value = "QRstart")Instant qrstart,
            @RequestParam(value = "duration",defaultValue = "5")Integer duration,
            @RequestParam(value = "currentDateTime",defaultValue = "null")Instant currentDateTime,
            @RequestParam(name = "lat",value = "lat",required = false,defaultValue = "0")double lat,
            @RequestParam(name = "long",value = "long",required = false,defaultValue = "0")double lng,
            Authentication authentication){
//        byte[] decodedBytes = Base64.getDecoder().decode(qrInfo);
//        String decodedString = new String(decodedBytes);
//        String[] decodedInfo = decodedString.split("&");
//        Instant qrstart = Instant.parse(decodedInfo[0]);
//        Integer ueid = Integer.valueOf(decodedInfo[1]);
//        Integer duration = Integer.valueOf(decodedInfo[2]);
//        Instant currentDateTime = Instant.parse(decodedInfo[3]);
//        double lat = 0;
//        double lng = 0;
//        if(decodedInfo.length>4){
//             lat = Double.parseDouble(decodedInfo[4]);
//             lng = Double.parseDouble(decodedInfo[5]);
//        }

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
                            logService.saveAndFlushLog(LogSection.VALIDATE, LogState.QR_GPS,"Validate event " + usersEvent.getEvent().getTitle() + " success", usersEvent.getUser(), event.getId());
                            return ResponseEntity.ok().body("Success");
                        }
                    }
                    response = "Success";
                    System.out.println("Success");
                    usersEvent.setStatus("S");
                    logService.saveAndFlushLog(LogSection.VALIDATE, LogState.QRCODE,"Validate event " + usersEvent.getEvent().getTitle() + " success", usersEvent.getUser(),event.getId());
                    userEventRepo.save(usersEvent);


                } else {
                    System.out.println("validate failed");
                    usersEvent.setStatus("F");
                    userEventRepo.save(usersEvent);
                    logService.saveAndFlushLog(LogSection.VALIDATE, LogState.QRCODE,"Validate event " + usersEvent.getEvent().getTitle() + " failed", usersEvent.getUser(), event.getId());
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
