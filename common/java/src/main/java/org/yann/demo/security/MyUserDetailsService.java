// package org.yann.demo.security;

// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.security.core.userdetails.UserDetails;
// import org.springframework.security.core.userdetails.UserDetailsService;
// import org.springframework.security.core.userdetails.UsernameNotFoundException;
// import org.yann.demo.repository.UserRepository;
// import org.yann.demo.model.User;


// public class MyUserDetailsService implements UserDetailsService {

//     @Autowired
//     private UserRepository userRepository; 

//     @Override
//     public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

//         User user = userRepository.findByUsername(username);

//         if (username == null) {
//             throw new UsernameNotFoundException("User not found with username: " + username);
//         }

//         // Map user data to UserDetails object
//         return new MyUserDetails(
//                 user.getUsername(),
//                 user.getPassword(), // Assuming password is stored securely
//                 null, user.isEnabled() // Assuming an "enabled" flag exists in the User entity
//         );

//     }

// }