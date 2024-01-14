package backend.vevent.server.Controller;


import backend.vevent.server.Entity.Event;
import backend.vevent.server.Repo.EventRepo;
import backend.vevent.server.Service.EventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
public class EventController {

    private EventService eventService;

    @Autowired
    private EventRepo eventRepo;


    @GetMapping("/testqrcode")
    public List<Event> getEventList(){
        return eventRepo.findAll();
    }

}
