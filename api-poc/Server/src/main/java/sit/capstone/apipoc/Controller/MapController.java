package sit.capstone.apipoc.Controller;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import sit.capstone.apipoc.DTO.LatLng;

@RestController
public class MapController {

    @Value("${api.key}")
    private String api_key;

    @RequestMapping("/api/longdo/")
    public ResponseEntity<Object> findDistance(@RequestBody LatLng location){

        RestTemplate restTemplate = new RestTemplate();

        System.out.println(api_key);
        Object result = restTemplate.getForObject(
                "https://api.longdo.com/RouteService/json/route/guide?flon="+location.getFlon()+"&flat="+location.getFlat()+"&tlon="+location.getTlon()+"&tlat="+location.getTlat()+"&mode=t&type=25&locale=th&key="+api_key,Object.class);

        System.out.println(result);
        return new ResponseEntity<>(result, HttpStatus.OK);

    }
}

