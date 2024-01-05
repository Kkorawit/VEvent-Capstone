package backend.vevent.server.Controller;


import backend.vevent.server.Entity.Event;
import backend.vevent.server.Entity.User;
import backend.vevent.server.Entity.UsersEvent;
import backend.vevent.server.Repo.EventRepo;
import backend.vevent.server.Repo.UserEventRepo;
import backend.vevent.server.Repo.UserRepo;
import graphql.GraphQL;
import graphql.util.Pair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Controller
public class GraphQLController {

    private EventRepo eventRepo;

    @Autowired
    private UserEventRepo userEventRepo;

    @Autowired
    private UserRepo userRepo;

    private GraphQL graphQL;

    public GraphQLController(EventRepo eventRepo) {
        this.eventRepo = eventRepo;
    }

//    @SchemaMapping(typeName = "Query", value = "allEvents")
//    @PostMapping("/graphql")
    @QueryMapping
    public List<Event> allEvents(){
        System.out.println("in controller1");
//        ExecutionResult executionResult = graphQL.execute(query);
//        System.out.println(executionResult);
//        String result = executionResult.toSpecification().toString();
//        System.out.println(result);
//        System.out.println("in controller");
        return eventRepo.getAllEvents();
    }

    @QueryMapping
    public List<UsersEvent> findAllRegisEventsByUEmail(@Argument String uEmail){
        List<UsersEvent> eventList = userEventRepo.findAllRegisEventByUEmail(uEmail);
//        switch (user.getRole()){
//            case "Organization":
//                System.out.println(user.getRole());
//               eventsList = eventRepo.findAllEventByCreator(uEmail);
//               break;
//            case "Participants":
//            default:
//                System.out.println(user.getRole());
//                eventsList = userEventRepo.findAllEventByUEmail(uEmail);
//        }
//
//        return eventsList;
        return eventList;
    }

    @QueryMapping
    public List<Event> findAllEventCreateByUEmail(@Argument String uEmail){
        List<Event> eventList = eventRepo.findAllEventCreateByUEmail(uEmail);
        return eventList;
    }


    @QueryMapping
    public Event findEventById(@Argument Integer id){
        return eventRepo.findEventById(id);
    }

    @QueryMapping
    public User findUserByEmail(@Argument String uEmail){
        User user = userRepo.findUserByEmail(uEmail);
//        if(user == null){
//            return new ResponseEntity("User Not Found",HttpStatus.NOT_FOUND);
//        }
        return user;
    }

    @QueryMapping
    public List<UsersEvent> findAllParticipantsByEventId(@Argument Integer eid){
        List<UsersEvent> usersEventList = userEventRepo.findAllUserByEid(eid);
//        if(usersEventList.isEmpty()){
//
//        }else {
//
//        }
        return usersEventList;
    }
}
