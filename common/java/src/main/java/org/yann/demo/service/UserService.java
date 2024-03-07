package org.yann.demo.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.yann.demo.controller.UploadController;
import org.yann.demo.model.User;

@Service
public class UserService{

    Logger logger = LoggerFactory.getLogger(UploadController.class);


    @Autowired
    JdbcTemplate jdbcTemplate;

    public UserService() {
    }

    public void getUser(String username) {
        try {
            jdbcTemplate.query(
                "SELECT login, email FROM TBL_USERS WHERE login = " + username,
                (rs, rowNum) -> new User(rs.getString("login"), rs.getString("email")), 
                "")
            .forEach(u -> System.out.println(u.toString()));
        } catch (DataAccessException ex) {
            logger.error("Couldn't connect to the DB");
        }

    }
}   