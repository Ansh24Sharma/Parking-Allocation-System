package com.yash.parkingallocation.service;

import com.yash.parkingallocation.domain.User;
import com.yash.parkingallocation.exception.UserBlockedException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface UserService {

    public static final Integer LOGIN_STATUS_ACTIVE=1;
    public static final Integer LOGIN_STATUS_BLOCKED=2;

    public static final Integer ROLE_ADMIN=1;
    public static final Integer ROLE_USER=2;

    public void register(User u);

    public User login(String loginName, String password) throws UserBlockedException;

    public List<User> getUserList();

    public void changeLoginStatus(Integer userId, Integer loginStatus);

    public Boolean isUsernameExist(String username);

    public List<User> findAllUsers();

    int getTotalUsers();

    List<Map<String, Object>> getDetailedReports();
}
