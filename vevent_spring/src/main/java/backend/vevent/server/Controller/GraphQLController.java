package backend.vevent.server.Controller;


import backend.vevent.server.Entity.Event;
import backend.vevent.server.Entity.User;
import backend.vevent.server.Entity.UsersEvent;
import backend.vevent.server.Repo.EventRepo;
import backend.vevent.server.Repo.UserEventRepo;
import backend.vevent.server.Repo.UserRepo;
import com.spencerwi.either.Either;
import graphql.GraphQL;
import graphql.util.Pair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Controller
@CrossOrigin("*")
public class GraphQLController {

    @Autowired
    private EventRepo eventRepo;

    @Autowired
    private UserEventRepo userEventRepo;

    @Autowired
    private UserRepo userRepo;

    private GraphQL graphQL;


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
        System.out.println(eventList);
        return eventList;
    }

    @QueryMapping
    public List<Event> findAllEventCreatedByUEmail(@Argument String uEmail){
        List<Event> eventList = eventRepo.findAllEventCreateByUEmail(uEmail);
        System.out.println(eventList);
        return eventList;
    }

    @QueryMapping
    public UsersEvent findEventDetailsByUserEventId(@Argument Integer id){
        UsersEvent usersEvent = userEventRepo.findUsersEventById(id);
        return usersEvent;
    }

    @QueryMapping
    public Event findEventDetailsByEventId(@Argument Integer id){
        Event event = eventRepo.findEventById(id);
        return event;
    }

//   @QueryMapping
//   public static Either<String, Integer> computeWithEither(int marks) {
//       if (marks < 85) {
//           return Either.left("Marks not acceptable");
//       } else {
//           return Either.right(marks);
//       }
//   }

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
