package backend.vevent.server.Service;


import backend.vevent.server.Entity.Event;
import backend.vevent.server.Repo.EventRepo;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Service
public class EventService {

    private EventRepo eventRepo;


    public ResponseEntity<List<Event>> getEventByUserId(Integer uid){
        List<Event> eventsList = eventRepo.getEventByUid(uid);
        System.out.println(eventsList);

        if(eventsList.isEmpty()){
            System.out.println("NOT HAVE EVENTS");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
//            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }


        return ResponseEntity.ok(eventsList);

    }

}
