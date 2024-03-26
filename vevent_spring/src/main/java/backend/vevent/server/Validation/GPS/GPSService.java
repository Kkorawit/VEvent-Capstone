package backend.vevent.server.Validation.GPS;

import backend.vevent.server.Entities.Event;
import backend.vevent.server.Repo.EventRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.HashMap;

@Service
public class GPSService {

    @Autowired
    private EventRepo eventRepo;

    public double calHaversine(LatLngDTO location,Integer eid){
        Event event = eventRepo.findEventById(eid);


        double dLat = Math.toRadians((event.getLocationLatitude() - location.getFlat()));
        double dLong = Math.toRadians((event.getLocationLongitude() - location.getFlong()));

        double startLat = Math.toRadians(location.getFlat());
        double endLat = Math.toRadians(event.getLocationLatitude());
        System.out.println("In service");
//        return Math.pow(Math.sin(val / 2), 2);

        double haversine = Math.pow(Math.sin(dLat / 2), 2) + Math.cos(startLat) * Math.cos(endLat) * Math.pow(Math.sin(dLong / 2), 2);
        return haversine;
    }

    public HashMap<String, Object> calDisplacementWithHaversine(double hav) {

        System.out.println("On cal displacement");
        System.out.println("hav: " + hav);
        final double EARTH_RADIUS = 6371;
        double c = 2 * Math.atan2(Math.sqrt(hav),Math.sqrt(1- hav));
        BigDecimal bigDecimal = new BigDecimal(EARTH_RADIUS*c);
        BigDecimal displacementInDecimal = bigDecimal.setScale(5, RoundingMode.HALF_UP);
        double displacementInDouble = displacementInDecimal.toBigInteger().doubleValue();
        System.out.println("In double: "+displacementInDouble);
        System.out.println("In Decimal: "+displacementInDecimal);
        HashMap<String, Object> response = new HashMap<>();

        if(displacementInDouble>0.5) {
            System.out.println("failed");
            response.put("VStatus", "Failed");
            response.put("Displacement",displacementInDouble+"km");
            response.put("HTTP_Status", HttpStatus.OK.value());
            System.out.println("out from status failed");
        }else{
            System.out.println("pass");
            response.put("VStatus", "Success");
            response.put("Displacement",displacementInDouble+"km");
            response.put("HTTP_Status",HttpStatus.OK.value());
        }
        return response;
    }

}
