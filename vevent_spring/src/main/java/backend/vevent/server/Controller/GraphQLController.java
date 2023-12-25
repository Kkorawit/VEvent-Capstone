package backend.vevent.server.Controller;


import backend.vevent.server.Entity.Event;
import backend.vevent.server.Entity.User;
import backend.vevent.server.Entity.UsersEvent;
import backend.vevent.server.Repo.EventRepo;
import backend.vevent.server.Repo.UserEventRepo;
import backend.vevent.server.Repo.UserRepo;
import graphql.GraphQL;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;

import java.util.List;
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
    public List<UsersEvent> findAllEventsByUEmail(@Argument String uEmail){

        return userEventRepo.findAllEventByUEmail(uEmail);
    }


//    @QueryMapping
//    public Optional<Event> findById(@Argument Integer id){
//        return eventRepo.findById(id);
//    }

    @QueryMapping
    public Optional<User> findUserByEmail(@Argument String uEmail){
        return userRepo.findUserByEmail(uEmail);
    }

}