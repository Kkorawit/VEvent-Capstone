package backend.vevent.server.Validation.GPS;


import backend.vevent.server.Entity.Event;
import backend.vevent.server.Entity.UsersEvent;
import backend.vevent.server.Repo.EventRepo;
import backend.vevent.server.Repo.UserEventRepo;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.util.Optional;


@RestController
public class GPSController {

    @Autowired
    private EventRepo eventRepo;

    @Autowired
    private UserEventRepo userEventRepo;

    @Value("${api.key}")
    private String api_key;

    @RequestMapping("/api/longdo")
    public ResponseEntity findDistance(@RequestBody LatLngDTO location, @RequestParam(name = "eid")Integer eid, @RequestParam(name = "uemail")String uEmail) throws IOException {

        RestTemplate restTemplate = new RestTemplate();
        Optional<Event> event = eventRepo.findById(eid);
        UsersEvent usersEvent = userEventRepo.findByEmailAndId(uEmail,eid);

        if(event.get().getLocationLatitude() == null || event.get().getLocationLongitude() == null){
            return ResponseEntity.badRequest().body("This Event Don't Registered The Event Location");
        }else if(usersEvent!=null){

            String result = restTemplate.getForObject(
                    "https://api.longdo.com/RouteService/json/route/guide?flon="+location.getFlong()+
                            "&flat="+location.getFlat()+ "&tlon="+event.get().getLocationLongitude()+"&tlat="+event.get().getLocationLatitude()+
                            "&mode=t&type=25&locale=th&key="+api_key, String.class);
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(result);

            float distanceValue = jsonNode.at("/data/0/distance").asInt();

            if (distanceValue <= 3000) {
                usersEvent.setStatus("S");
                System.out.println(usersEvent);
                userEventRepo.save(usersEvent);
                return new ResponseEntity("Success", HttpStatus.OK);
            }
            usersEvent.setStatus("F");
            System.out.println(usersEvent);
            userEventRepo.save(usersEvent);
            return new ResponseEntity("You're Not Around The Area", HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity("Event Not Found",HttpStatus.NOT_FOUND);
//        JsonReader meta = objectMapper.readValue(result,JsonReader.class);
//        System.out.println(distanceValue);
    }
}
