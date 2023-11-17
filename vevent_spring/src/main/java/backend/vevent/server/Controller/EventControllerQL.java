package backend.vevent.server.Controller;


import backend.vevent.server.Entity.Event;
import backend.vevent.server.Entity.UsersEvent;
import backend.vevent.server.Repo.EventRepo;
import backend.vevent.server.Repo.UserEventRepo;
import graphql.GraphQL;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Controller
public class EventControllerQL {

    private EventRepo eventRepo;

    @Autowired
    private UserEventRepo userEventRepo;

    private GraphQL graphQL;

    public EventControllerQL(EventRepo eventRepo) {
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
    public List<UsersEvent> findAllEventsByUid(@Argument Integer uid){
        System.out.println(uid);
        List<UsersEvent> events = userEventRepo.findAllEventByUid(uid);
//        System.out.println("HELLO BOID");
//        for(int i=0;i<events.size();i++){
//            System.out.println(events.get(i).getUid().getName());
//
//            System.out.println(events.get(i).getEid().getTitle());
//        }
//        System.out.println(events);

        return events;
    }

    @QueryMapping
    public Optional<Event> findById(@Argument Integer id){
        return eventRepo.findById(id);
    }

}
