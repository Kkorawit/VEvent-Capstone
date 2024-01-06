package backend.vevent.server.Validation.GPS;


import backend.vevent.server.Entity.Event;
import backend.vevent.server.Entity.UsersEvent;
import backend.vevent.server.Repo.EventRepo;
import backend.vevent.server.Repo.UserEventRepo;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spencerwi.either.Either;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.repository.query.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.HashMap;
import java.util.Optional;


@RestController
@RequestMapping("/api")
public class GPSController {

    @Autowired
    private EventRepo eventRepo;

    @Autowired
    private UserEventRepo userEventRepo;

    @Value("${api.key}")
    private String api_key;

    @Autowired
    private GPSService service;

    @RequestMapping("/longdo")
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
            System.out.println(distanceValue);
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

    @RequestMapping("/either")
    private static Either<String, Integer> computeWithEither(@RequestParam(name = "marks") int marks) {
        if (marks < 85) {
            System.out.println("left");
            return Either.left("Marks not acceptable");
        } else {
            System.out.println("right");
            return Either.right(marks);
        }
    }

    @RequestMapping("/distance")
    public ResponseEntity findDisplacement(@RequestBody LatLngDTO location, @RequestParam(name = "eid")Integer eid, @RequestParam(name = "uemail")String uEmail){
        Optional<Event> event = eventRepo.findById(eid);
        UsersEvent usersEvent = userEventRepo.findByEmailAndId(uEmail,eid);
//        double lat1 = 13.6495877; //บ้าน ธรรมรักษา2
//        double lat2 = 13.6524898; //SIT KMUTT
//        double lon1 = 100.4919303;
//        double lon2 = 100.4910494;

//        double dLat = Math.toRadians((lat2-lat1));
//        double dLong = Math.toRadians((lon2-lon1));
//
//        double startLat = Math.toRadians(lat1);
//        double endLat = Math.toRadians(lat2);
//        System.out.println("before service");
//        double a = service.calHaversine(dLat) + Math.cos(startLat) * Math.cos(endLat) * service.calHaversine(dLong);
//        double c = 2 * Math.atan2(Math.sqrt(a),Math.sqrt(1-a));
//
//        System.out.println(EARTH_RADIUS*c);
//        return ResponseEntity.ok().body(EARTH_RADIUS*c);
        System.out.println(usersEvent);
        HashMap<String, Object> response = new HashMap<>();
//        HashMap<String,HttpStatus> HttpStatusaa = new HashMap<>();
        switch (event.get().getEventStatus()){
            case "ON":
                if (usersEvent != null && !usersEvent.getStatus().equals("S") && !usersEvent.getStatus().equals("P")) {

                    double dLat = Math.toRadians((event.get().getLocationLatitude() - location.getFlat()));
                    double dLong = Math.toRadians((event.get().getLocationLongitude() - location.getFlong()));

                    double startLat = Math.toRadians(location.getFlat());
                    double endLat = Math.toRadians(event.get().getLocationLatitude());
                    System.out.println("before service");
                    double haversine = service.calHaversine(dLat) + Math.cos(startLat) * Math.cos(endLat) * service.calHaversine(dLong);
                    response = calDisplacementWithHaversine(haversine);

                    if (response.get("Status").equals("Success")) {
                        usersEvent.setStatus("S");
                        userEventRepo.save(usersEvent);
                    } else {
                        usersEvent.setStatus("F");
                        userEventRepo.save(usersEvent);
                    }
                    return ResponseEntity.ok().body(response);
                } else if (usersEvent.getStatus().equals("S")) {
                    response.put("VStatus","Event Verified Passed");
                    response.put("Displacement",null);
                    response.put("HTTP_Status", HttpStatus.BAD_REQUEST.value());
                }else{
                    response.put("VStatus","This Event Validation Not Open yet");
                    response.put("Displacement",null);
                    response.put("HTTP_Status", HttpStatus.BAD_REQUEST.value());
                }
                break;

            case "UP":
                response.put("VStatus","This Event is Not Start Yet");
                response.put("Displacement",null);
                response.put("HTTP_Status", HttpStatus.BAD_REQUEST.value());
                break;

            default:
                response.put("VStatus","This Event Validation Closed");
                response.put("Displacement",null);
                response.put("HTTP_Status", HttpStatus.BAD_REQUEST.value());

        }
        return ResponseEntity.badRequest().body(response);
    }

    private static HashMap<String, Object> calDisplacementWithHaversine(double hav) {
        final double EARTH_RADIUS = 6371;
        double c = 2 * Math.atan2(Math.sqrt(hav),Math.sqrt(1- hav));
        BigDecimal bigDecimal = new BigDecimal(EARTH_RADIUS*c);
        BigDecimal displacementInDecimal = bigDecimal.setScale(5,RoundingMode.HALF_UP);
        double displacementInDouble = displacementInDecimal.toBigInteger().doubleValue();

        HashMap<String, Object> response = new HashMap<>();

        if(displacementInDouble>0.5) {
            response.put("VStatus", "Failed");
            response.put("Displacement",displacementInDouble+"km");
            response.put("HTTP_Status",HttpStatus.OK.value());
        }else{
            response.put("VStatus", "Success");
            response.put("Displacement",displacementInDouble+"km");
            response.put("HTTP_Status",HttpStatus.OK.value());
        }
        return response;
    }

    @RequestMapping("/vin")
    public ResponseEntity vinDistance(){

        double SEMI_MAJOR_AXIS_MT = 6378137;
        double SEMI_MINOR_AXIS_MT = 6356752.314245;
        double FLATTENING = 1 / 298.257223563;
        double ERROR_TOLERANCE = 1e-12;

        double lat1 = 13.6495877;
        double lat2 = 13.6524898;
        double lon1 = 100.4919303;
        double lon2 = 100.4910494;

        double U1 = Math.atan((1 - FLATTENING) * Math.tan(Math.toRadians(lat1)));
        double U2 = Math.atan((1 - FLATTENING) * Math.tan(Math.toRadians(lat2)));
//        0.33492439918701683
//        0.3364440809990891
//        0.33642789280825347
        double sinU1 = Math.sin(U1);
        double cosU1 = Math.cos(U1);
        double sinU2 = Math.sin(U2);
        double cosU2 = Math.cos(U2);

        double longitudeDifference = Math.toRadians(lon2 - lon1);
        double previousLongitudeDifference;

        double sinSigma, cosSigma, sigma, sinAlpha, cosSqAlpha, cos2SigmaM;

        do {
            sinSigma = Math.sqrt(Math.pow(cosU2 * Math.sin(longitudeDifference), 2) +
                    Math.pow(cosU1 * sinU2 - sinU1 * cosU2 * Math.cos(longitudeDifference), 2));
            cosSigma = sinU1 * sinU2 + cosU1 * cosU2 * Math.cos(longitudeDifference);
            sigma = Math.atan2(sinSigma, cosSigma);
            sinAlpha = cosU1 * cosU2 * Math.sin(longitudeDifference) / sinSigma;
            cosSqAlpha = 1 - Math.pow(sinAlpha, 2);
            cos2SigmaM = cosSigma - 2 * sinU1 * sinU2 / cosSqAlpha;
            if (Double.isNaN(cos2SigmaM)) {
                cos2SigmaM = 0;
            }
            previousLongitudeDifference = longitudeDifference;
            double C = FLATTENING / 16 * cosSqAlpha * (4 + FLATTENING * (4 - 3 * cosSqAlpha));
            longitudeDifference = Math.toRadians(lon2 - lon1) + (1 - C) * FLATTENING * sinAlpha *
                    (sigma + C * sinSigma * (cos2SigmaM + C * cosSigma * (-1 + 2 * Math.pow(cos2SigmaM, 2))));
        } while (Math.abs(longitudeDifference - previousLongitudeDifference) > ERROR_TOLERANCE);

        double uSq = cosSqAlpha * (Math.pow(SEMI_MAJOR_AXIS_MT, 2) - Math.pow(SEMI_MINOR_AXIS_MT, 2)) / Math.pow(SEMI_MINOR_AXIS_MT, 2);

        double A = 1 + uSq / 16384 * (4096 + uSq * (-768 + uSq * (320 - 175 * uSq)));
        double B = uSq / 1024 * (256 + uSq * (-128 + uSq * (74 - 47 * uSq)));

        double deltaSigma = B * sinSigma * (cos2SigmaM + B / 4 * (cosSigma * (-1 + 2 * Math.pow(cos2SigmaM, 2))
                - B / 6 * cos2SigmaM * (-3 + 4 * Math.pow(sinSigma, 2)) * (-3 + 4 * Math.pow(cos2SigmaM, 2))));

        double distanceMt = SEMI_MINOR_AXIS_MT * A * (sigma - deltaSigma);
        return ResponseEntity.ok().body(distanceMt/1000);

    }

    @RequestMapping("/dis")
    public double distance(){

        double lat1 = 13.6495877;
        double lat2 = 13.6524898;
        double lon1 = 100.4919303;
        double lon2 = 100.4910494;
        char unit  = 'K';
        double theta = lon1 - lon2;
        double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
        dist = Math.acos(dist);
        dist = rad2deg(dist);
        dist = dist * 60 * 1.1515;
        if (unit == 'K') {
            dist = dist * 1.609344;
        } else if (unit == 'N') {
            dist = dist * 0.8684;
        }
        return (dist);
    }
    private double deg2rad(double deg) {
        return (deg * Math.PI / 180.0);
    }
    private double rad2deg(double rad) {
        return (rad * 180.0 / Math.PI);
    }

}
