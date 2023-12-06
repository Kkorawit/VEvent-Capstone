package backend.vevent.server.Validation.GPS;


import backend.vevent.server.Entity.Event;
import backend.vevent.server.Repo.EventRepo;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.JSONPObject;
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

    @Value("${api.key}")
    private String api_key;

    @RequestMapping("/api/longdo")
    public ResponseEntity findDistance(@RequestBody LatLngDTO location, @RequestParam(name = "eid")Integer eid) throws IOException {

        RestTemplate restTemplate = new RestTemplate();
        Optional<Event> event = eventRepo.findById(eid);

        if(event.get().getLocationLatitude() == null || event.get().getLocationLongitude() == null){
            return ResponseEntity.badRequest().body("This Event Don't Registed The Event Location");
        }else{
            String result = restTemplate.getForObject(
                    "https://api.longdo.com/RouteService/json/route/guide?flon="+location.getFlong()+
                            "&flat="+location.getFlat()+ "&tlon="+event.get().getLocationLongitude()+"&tlat="+event.get().getLocationLatitude()+
                            "&mode=t&type=25&locale=th&key="+api_key, String.class);
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(result);
            System.out.println("result : "+result);
            System.out.println("jsonnode : " + jsonNode);
            float distanceValue = jsonNode.at("/data/0/distance").asInt();
            System.out.println(distanceValue);
//            if (distanceValue < 6000) {
//                return new ResponseEntity("Success", HttpStatus.OK);
//            }
            return new ResponseEntity(jsonNode, HttpStatus.BAD_REQUEST);
        }

//        JsonReader meta = objectMapper.readValue(result,JsonReader.class);
//        System.out.println(distanceValue);


    }
}
