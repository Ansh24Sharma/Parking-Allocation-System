package com.yash.parkingallocation.dao;

import com.yash.parkingallocation.domain.Parking;
import com.yash.parkingallocation.domain.User;
import com.yash.parkingallocation.domain.Vehicle;

import java.util.List;
import java.util.Map;

public interface UserDAO {

     public void save(User user);
     public void update(User user);
     public void delete(User user);
     public void delete(Integer userId);
     public User findById(Integer userId);
     public List<User> findAllUsers();
     public List<User> findByProperty(String propName ,Object propValue );
     List<Vehicle> findVehiclesByUserId(int userId);
     List<Parking> findParkingByVehicleId(int vehicleId);
     List<Map<String, Object>> findDetailedReports();
     int countUsers();
}
