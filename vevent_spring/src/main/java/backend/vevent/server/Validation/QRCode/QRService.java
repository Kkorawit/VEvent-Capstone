package backend.vevent.server.Validation.QRCode;

import backend.vevent.server.Entity.Event;
import backend.vevent.server.Repo.EventRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.temporal.ChronoUnit;

@Service
public class QRService {

    @Autowired
    private EventRepo eventRepo;

    public boolean QrTimeCheck(Instant qrStart,Integer duration,Instant currentDateTime){

        Boolean isInTime = false;

        if (currentDateTime.isBefore(qrStart) || currentDateTime.isAfter(qrStart.plus(duration, ChronoUnit.MINUTES))){
            isInTime = false;
        }else if (currentDateTime.isAfter(qrStart)&&currentDateTime.isBefore(qrStart.plus(duration,ChronoUnit.MINUTES))){
            isInTime = true;
        }
        return isInTime;
    }

    public String EventTimeCheck(Integer eid,Instant currentDateTime){

        Event event = eventRepo.findEventById(eid);
        String timeStatus = null;

        if (currentDateTime.isBefore(event.getStartDate())){
            timeStatus = "This Event Haven't Start Yet";
        } else if (currentDateTime.isAfter(event.getEndDate())) {
            timeStatus = "This Event Ended";
        } else if (currentDateTime.isBefore(event.getEndDate())&& currentDateTime.isAfter(event.getStartDate())) {
            timeStatus = "During the Activity";
        }
        return timeStatus;
    }
}
