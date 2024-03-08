// package org.yann.demo.security;

// import java.util.Collection;

// import org.springframework.security.core.GrantedAuthority;
// import org.springframework.security.core.userdetails.UserDetails;

// public class MyUserDetails implements UserDetails {

//     private final String username;
//     private final String password;
//     private final Collection<? extends GrantedAuthority> authorities;
//     private final boolean enabled;

//     public MyUserDetails(String username, String password, Collection<? extends GrantedAuthority> authorities, boolean enabled) {
//         this.username = username;
//         this.password = password;
//         this.authorities = authorities;
//         this.enabled = enabled;
//     }

//     @Override
//     public Collection<? extends GrantedAuthority> getAuthorities() {
//         return authorities;
//     }

//     @Override
//     public String getPassword() {
//         return password;
//     }

//     @Override
//     public String getUsername() {
//         return username;
//     }

//     @Override
//     public boolean isAccountNonExpired() {
//         return false;
//     }

//     @Override
//     public boolean isAccountNonLocked() {
//         return false;
//     }

//     @Override
//     public boolean isCredentialsNonExpired() {
//         return false;
//     }

//     @Override
//     public boolean isEnabled() {
//         return enabled;
//     }
    
// }
