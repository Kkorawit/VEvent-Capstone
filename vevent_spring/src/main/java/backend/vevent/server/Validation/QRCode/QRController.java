package backend.vevent.server.Validation.QRCode;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;

@RestController
@RequestMapping("/api")
public class QRController {


    @Autowired
    private QRService qrService;

    @PostMapping("/qrcode")
    public ResponseEntity validateQRCode(@RequestParam(value = "eid")Integer eid,
                                         @RequestParam(value = "QRstart")Instant qrstart,
                                         @RequestParam(value = "duration",defaultValue = "5")Integer duration,
                                         @RequestParam(value = "currentDateTime",defaultValue = "null")Instant currentDateTime){

        boolean isInTime = qrService.QrTimeCheck(qrstart,duration,currentDateTime);
        String EventTimeStatus = qrService.EventTimeCheck(eid, currentDateTime);
        if (isInTime && EventTimeStatus.equals("During the Activity")){
            return ResponseEntity.ok().body("Validate Success");
        }else {
            return ResponseEntity.badRequest().body(EventTimeStatus);
        }

    }




}
