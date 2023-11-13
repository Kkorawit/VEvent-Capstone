package sit.capstone.apipoc.Controller;


import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.tomcat.util.json.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import sit.capstone.apipoc.DTO.JsonReader;
import sit.capstone.apipoc.DTO.LatLng;

import java.io.IOException;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.Map;

@RestController
public class MapController {

    @Value("${api.key}")
    private String api_key;

    @RequestMapping("/api/longdo/")
    public ResponseEntity findDistance(@RequestBody LatLng location) throws IOException {

        RestTemplate restTemplate = new RestTemplate();

        System.out.println(api_key);
        String result = restTemplate.getForObject(
<<<<<<< refs/remotes/origin/dev
                "https://api.longdo.com/RouteService/json/route/guide?flon=" + location.getFlon() + "&flat=" + location.getFlat() + "&tlon=" + location.getTlon() + "&tlat=" + location.getTlat() + "&mode=t&type=25&locale=th&key=" + api_key, String.class);
=======
                "https://api.longdo.com/RouteService/json/route/guide?flon="+location.getFlon()+
                        "&flat="+location.getFlat()+ "&tlon="+location.getTlon()+"&tlat="+location.getTlat()+
                        "&mode=t&type=25&locale=th&key="+api_key, String.class);
>>>>>>> local

        System.out.println(result);
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonNode = objectMapper.readTree(result);
        float distanceValue = jsonNode.at("/data/0/distance").asInt();
//        JsonReader meta = objectMapper.readValue(result,JsonReader.class);
        System.out.println(distanceValue);
        if (distanceValue < 6000) {
            return new ResponseEntity("Success", HttpStatus.OK);
        }
        return new ResponseEntity("Event failed", HttpStatus.BAD_REQUEST);

    }
}

