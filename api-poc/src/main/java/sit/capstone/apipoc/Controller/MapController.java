package sit.capstone.apipoc.Controller;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class MapController {

    @RequestMapping("/")
    public String index() {
        //you can replace this with any Here API you need
        final String uri = "https://autocomplete.geocoder.api.here.com/6.2/suggest.json"
                + "?app_id=xxxx"
                + "&app_code=xxxx"
                + "&beginHighlight=%3Cb%3E"
                + "&endHighlight=%3C/b%3E"
                + "&maxresults=20"
                + "&query=India&gen=9";

        RestTemplate restTemplate = new RestTemplate();
        String result = restTemplate.getForObject(uri, String.class);

        return result;
    }
}
