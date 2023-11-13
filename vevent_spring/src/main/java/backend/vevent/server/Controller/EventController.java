package backend.vevent.server.Controller;


import backend.vevent.server.Entity.Event;
import backend.vevent.server.Service.EventService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class EventController {

    private EventService eventService;

    @RequestMapping("/api/kw1/events")
    public ResponseEntity<List<Event>> getEventsByUsers(@RequestParam Integer uid){
        return eventService.getEventByUserId(uid);
    }

}
