package com.finance.dao;

import com.finance.model.User;
import java.util.List;

public interface UserDao {
    void save(User user);
    User findByUsername(String username);
    List<User> findAll();
    void delete(Integer id);
    User validateUser(String username, String password);
}
