package backend.vevent.server.Controller;

import backend.vevent.server.Configure.JwtRequest;
import backend.vevent.server.Repo.UserRepo;
import backend.vevent.server.Service.JwtUserDetailsService;
import backend.vevent.server.Service.LogService;
import backend.vevent.server.Service.UserService;
import backend.vevent.server.Utils.JwtTokenUtil;
import backend.vevent.server.EnumValue.LogSection;
import backend.vevent.server.EnumValue.LogState;
import io.jsonwebtoken.impl.DefaultClaims;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.scrypt.SCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@CrossOrigin("*")
@RequestMapping("/api")
public class JwtAuthenticationController {


    private final AuthenticationManager authenticationManager;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Autowired
    private JwtUserDetailsService userDetailsService;

    @Autowired
    private SCryptPasswordEncoder passwordEncoder;

    @Autowired
    private UserService userService;

    @Autowired
    private LogService logService;

    @Autowired
    private UserRepo userRepo;

    public JwtAuthenticationController(AuthenticationManager authenticationManager) {
        this.authenticationManager = authenticationManager;
    }

    @PostMapping("/auth")
    public ResponseEntity<?> createAuthenticationToken(@RequestBody JwtRequest authenticationRequest) throws Exception {
//        authenticationRequest.setEmail(authenticationRequest.getEmail().toUpperCase());
        System.out.println("login pls");

        Map<String, String> tokens = new HashMap<>();
        System.out.println(authenticationRequest.getEmail());
        System.out.println(authenticationRequest.getDisplayName());
        System.out.println(authenticationRequest.getRole());
//        authenticate(authenticationRequest.getUsername(), authenticationRequest.getPassword());
//        String sCryptPasswordEncoded = passwordEncoder.encode(authenticationRequest.getPassword());

        final UserDetails userDetails = userDetailsService
                .loadUserByUsername(authenticationRequest.getEmail());


            System.out.println("in try");
            System.out.println(userDetails.getUsername());
//            System.out.println(passwordEncoder.matches(authenticationRequest.getEmail(),sCryptPasswordEncoded));
//            if (passwordEncoder.matches(authenticationRequest.getEmail(),sCryptPasswordEncoded)) {
                System.out.println("controller jwt : " + userDetails);
                if(userDetails.getUsername().equals("NEW")){
                    System.out.println("some thing in new");
                    if(authenticationRequest.getDisplayName() != null){
                        System.out.println("In authen notnull: "+authenticationRequest.getEmail());
                        boolean userCreated = userService.createAccount(authenticationRequest.getEmail(), authenticationRequest.getDisplayName(), authenticationRequest.getRole(), authenticationRequest.getProfileImg());
                        if(userCreated){

                            System.out.println("In user created");
                            backend.vevent.server.Entities.User newUser = userRepo.findUserByEmail(authenticationRequest.getEmail());
                            System.out.println("before save log");
                            logService.saveAndFlushLog(LogSection.CREATE, LogState.ACCOUNT,"Create Account: "+newUser.getUserEmail(),newUser,0);
                            System.out.println("after save log");
                            return ResponseEntity.ok().body("Account Created");
                        }else {
                            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("Can't Create User with: "+authenticationRequest.getEmail());
                        }

                    }
                    return ResponseEntity.accepted().body("Signup");
                }
                final String access_token = jwtTokenUtil.generateToken(userDetails);
                final String refresh_token = jwtTokenUtil.generateRefreshToken(userDetails);
                tokens.put("access_token", access_token);
                tokens.put("refresh_token", refresh_token);
//            } else {
//                throw new Exception("Some thing Wrong");
//            }

        return ResponseEntity.ok(tokens);
    }

    @GetMapping("/refresh-token")
    public ResponseEntity<?> refreshtoken(HttpServletRequest request) throws Exception {
        // From the HttpRequest get the claims
        DefaultClaims claims = (DefaultClaims) request.getAttribute("claims");
        String refreshToken = request.getHeader("Authorization").substring(7);
        System.out.println("refresh token API");
        String email = jwtTokenUtil.getUsernameFromToken(refreshToken);
        UserDetails user = userDetailsService.loadUserByUsername(email);

        String newToken = jwtTokenUtil.generateToken(user);
        Map<String,String> tokens = new HashMap<>();
        tokens.put("access_token",newToken);
        tokens.put("refresh_token",refreshToken);
//        Map<String, Object> expectedMap = getMapFromIoJsonwebtokenClaims(claims);
//        String token = jwtTokenUtil.doGenerateRefreshToken(expectedMap, expectedMap.get("sub").toString());
        return ResponseEntity.ok(tokens);
    }

//    private void authenticate(String username, String password) throws Exception {
//        try {
//            System.out.println("authenicate function : " + username);
//            System.out.println("authenicate function : " + password);
////            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
//        } catch (Exception e) {
//            throw new Exception("USER_DISABLED", e);
//        }
////        } catch (BadCredentialsException e) {
////            throw new Exception("INVALID_CREDENTIALS", e);
////        }
//    }
}
