package backend.vevent.server.Service;


import backend.vevent.server.Entities.Event;
import backend.vevent.server.Entities.User;
import backend.vevent.server.Repo.EventRepo;
import backend.vevent.server.Repo.UserRepo;
import backend.vevent.server.Validation.AuthorizationService;
import ch.qos.logback.core.rolling.helper.FileStoreUtil;
import org.apache.catalina.session.FileStore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

@Service
public class EventService {

    @Autowired
    private EventRepo eventRepo;

    @Autowired
    private UserRepo userRepo;
    @Autowired
    private AuthorizationService authorizationService;


    public ResponseEntity createEvent(Event newEvent, Authentication authentication) {

        Map<String,String> mappedAuthenticated = authorizationService.mapAuthenticated(authentication);
        if(mappedAuthenticated.isEmpty()){
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("");
        }
        User signedInUser = userRepo.findUserByEmail(mappedAuthenticated.get("userEmail"));
//        Firestore dbFirestore = FirestoreClient.getFirestore();
//        ApiFuture<WriteResult> collectionsApiFuture = dbFirestore.collection("NK-2/Poster_image").document(newEvent.getPosterImg()).set(newEvent.getPosterImg());
//        return collectionsApiFuture.get().getUpdateTime().toString();

        if(signedInUser!=null){
            switch (signedInUser.getRole()){
                default: case "Organization":
                    eventRepo.saveAndFlush(newEvent);
                    return ResponseEntity.status(HttpStatus.CREATED).body("Event Booked");
                case "Participants":
                    return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Don't Have Privilege");
            }
        }else{
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Account Not Found *"+mappedAuthenticated.get("userEmail")+"*");
        }
    }

    public ResponseEntity editEvent(Event newEvent,Authentication authentication){
        Map<String,String> mappedAuthenticated = authorizationService.mapAuthenticated(authentication);
        if(mappedAuthenticated.isEmpty()){
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("");
        }
        User signedInUser = userRepo.findUserByEmail(mappedAuthenticated.get("userEmail"));

        if(signedInUser!=null){
            Event event = eventRepo.findEventById(newEvent.getId());
            if(event==null){
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Can't Find Event");
            }
            switch (signedInUser.getRole()){
                default: case "Organization":
                    newEvent.setId(event.getId());
                    eventRepo.saveAndFlush(newEvent);
                    return ResponseEntity.status(HttpStatus.CREATED).body("Event Booked");
                case "Participants":
                    return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Don't Have Privilege");
            }
        }else{
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Account Not Found *"+mappedAuthenticated.get("userEmail")+"*");
        }

    }

    public ResponseEntity deleteEvent(Event event) throws IOException {
        eventRepo.delete(event);
        return ResponseEntity.status(HttpStatus.OK).body("Deleted");
    }


}
