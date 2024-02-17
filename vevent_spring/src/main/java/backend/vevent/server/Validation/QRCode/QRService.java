package backend.vevent.server.Validation.QRCode;

import backend.vevent.server.Entity.Event;
import backend.vevent.server.Entity.UsersEvent;
import backend.vevent.server.Repo.EventRepo;
import backend.vevent.server.Repo.UserEventRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.temporal.ChronoUnit;

@Service
public class QRService {

    @Autowired
    private EventRepo eventRepo;
    @Autowired
    private UserEventRepo userEventRepo;

    public boolean QrTimeCheck(Instant qrStart,Integer duration,Instant currentDateTime){

        Boolean isInTime = false;
        System.out.println("isBefore: "+currentDateTime.isBefore(qrStart));
        System.out.println("isAfter: "+currentDateTime.isAfter(qrStart.plus(duration, ChronoUnit.MINUTES)));
        System.out.println("plus duration: "+qrStart.plus(duration, ChronoUnit.MINUTES));
//        System.out.println("current: "+currentDateTime<qrStart);
//        currentDateTime>qrStart+duration

        if (currentDateTime.isBefore(qrStart) || currentDateTime.isAfter(qrStart.plus(duration, ChronoUnit.MINUTES))){
            System.out.println("validate false");
            isInTime = false;
        }else if (currentDateTime.isAfter(qrStart)&&currentDateTime.isBefore(qrStart.plus(duration,ChronoUnit.MINUTES))){
            System.out.println("validate true");
            isInTime = true;
        }
        return isInTime;
    }

    public String EventTimeCheck(Integer ueid,Instant qrStart,Integer duration){
        UsersEvent usersEvent = userEventRepo.findUsersEventById(ueid);
        Event event = eventRepo.findEventById(usersEvent.getEvent().getId());
        String timeStatus = null;

        if (qrStart.isBefore(event.getStartDate())){
            timeStatus = "This Event Haven't Start Yet";
        } else if (qrStart.isAfter(event.getEndDate())) {
            timeStatus = "This Event Ended";
        } else if (qrStart.isBefore(event.getEndDate())&& qrStart.isAfter(event.getStartDate()) && qrStart.plus(duration,ChronoUnit.MINUTES).isBefore(event.getEndDate())) {
            timeStatus = "During the Activity";
        }
        return timeStatus;
    }
}
