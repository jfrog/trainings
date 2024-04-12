// package org.yann.demo.repository;

// import org.springframework.data.jpa.repository.JpaRepository;
// import org.springframework.data.jpa.repository.Query;
// import org.yann.demo.model.User;

// public interface UserRepository extends JpaRepository<User, Long> {

//     @Query("SELECT login FROM TBL_USERS u WHERE login = ?1")
//     User findByUsername(String username);
// }