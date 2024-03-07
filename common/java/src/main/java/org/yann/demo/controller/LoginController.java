// package org.yann.demo.controller;

// import org.springframework.http.ResponseEntity;
// import org.springframework.security.authentication.AuthenticationManager;
// import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
// import org.springframework.stereotype.Controller;
// import org.springframework.web.bind.annotation.PostMapping;
// import org.springframework.web.bind.annotation.RequestBody;

// @Controller

// public class LoginController {

//     private final AuthenticationManager authenticationManager;

//     public LoginController(AuthenticationManager authenticationManager) {
//         this.authenticationManager = authenticationManager;
//     }

//     // @PostMapping("/login")
//     // public ResponseEntity<Void> login(@RequestBody LoginRequest loginRequest) {
//     //     UsernamePasswordAuthenticationToken authenticationRequest =
//     //         UsernamePasswordAuthenticationToken.unauthenticated(loginRequest.username(), loginRequest.password());
//     //     org.springframework.security.core.Authentication authenticationResponse =
//     //         this.authenticationManager.authenticate(authenticationRequest);
//     //     // ...
//     // }

//     public record LoginRequest(String username, String password) {
//     }

//     public AuthenticationManager getAuthenticationManager() {
//         return authenticationManager;
//     }

// }

