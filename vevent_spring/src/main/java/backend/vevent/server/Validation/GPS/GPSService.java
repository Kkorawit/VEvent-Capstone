package backend.vevent.server.Validation.GPS;

import backend.vevent.server.Entity.Event;
import org.springframework.stereotype.Service;

@Service
public class GPSService {

    public double calHaversine(double val){
        System.out.println(val);
        System.out.println("In service");
        return Math.pow(Math.sin(val / 2), 2);
    }

}
