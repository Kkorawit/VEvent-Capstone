package backend.vevent.server.Service;

import backend.vevent.server.Repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class JwtUserDetailsService implements UserDetailsService {


    @Autowired
    private UserRepo repository;

    @Autowired
    private UserService userService;

    @Override
    public UserDetails loadUserByUsername(String uEmail) throws UsernameNotFoundException {
//        System.out.println("username loading : " + username);

        backend.vevent.server.Entities.User user = repository.findUserByEmail(uEmail);
        if (user!=null) {
            System.out.println("user: "+user);
            Collection<SimpleGrantedAuthority> authorities = new ArrayList<>();
            authorities.add(new SimpleGrantedAuthority(user.getRole()));
//            System.out.println("authorities : "+authorities);
//            System.out.println(user.getUsername() +" ::  "+ user.getUserPassword());
            System.out.println(user.getDisplayName());
            return new User(user.getUserEmail(),user.getDisplayName(),authorities);
        } else {
            return new User("NEW", "NEW", new ArrayList<>());
//            throw new UsernameNotFoundException("User not found with username: " + uEmail);
        }
    }


}
