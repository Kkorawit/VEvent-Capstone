package backend.vevent.server.Controller;


import backend.vevent.server.Entity.Event;
import backend.vevent.server.Repo.EventRepo;
import graphql.GraphQL;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;

import java.util.List;
import java.util.Optional;

@Controller
public class EventControllerQL {

    private EventRepo eventRepo;
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

    public Optional<Event> findEvent(@Argument Integer id){
        return eventRepo.findById(id);
    }

}
