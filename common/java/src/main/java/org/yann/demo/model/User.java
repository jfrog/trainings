package org.yann.demo.model;

// import jakarta.persistence.EmbeddedId;
// import jakarta.persistence.Entity;
// import jakarta.persistence.GeneratedValue;
// import jakarta.persistence.GenerationType;
// import jakarta.persistence.Table;

// @Entity
// @Table(name = "TBL_USERS")
public class User {
    public User(Long id, String username, String password, boolean enabled) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.enabled = enabled;
    }

    public User(String username, String email) {
        this.username = username;
        this.email = email;
    }

    // @EmbeddedId
    // @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;   
    private String username;
    private String password;
    private String email;
    private boolean enabled;


    // getters
    public Long getId() {
        return id;
    }
 
    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public String getEmail() {
        return email;
    }

    // setters
    public void setId(Long id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
}
