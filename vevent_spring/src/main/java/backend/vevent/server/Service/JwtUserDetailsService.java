package backend.vevent.server.Service;

import backend.vevent.server.Repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;

@Service
public class JwtUserDetailsService implements UserDetailsService {


    @Autowired
    private UserRepo repository;

    @Override
    public UserDetails loadUserByUsername(String uEmail) throws UsernameNotFoundException {
//        System.out.println("username loading : " + username);

        backend.vevent.server.Entity.User user = repository.findUserByEmail(uEmail);
        if (user!=null) {
            System.out.println("user: "+user);
            Collection<SimpleGrantedAuthority> authorities = new ArrayList<>();
            authorities.add(new SimpleGrantedAuthority(user.getRole()));
//            System.out.println("authorities : "+authorities);
//            System.out.println(user.getUsername() +" ::  "+ user.getUserPassword());
            return new User(user.getUserEmail(),user.getName(),authorities);
        } else {
            throw new UsernameNotFoundException("User not found with username: " + uEmail);
        }
    }
}
