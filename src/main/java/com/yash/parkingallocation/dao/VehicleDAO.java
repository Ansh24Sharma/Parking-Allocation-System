package com.yash.parkingallocation.dao;

import com.yash.parkingallocation.domain.User;
import com.yash.parkingallocation.domain.Vehicle;

import java.util.List;


public interface VehicleDAO {
    void save(Vehicle vehicle);
    void delete(int vehicleId);
    List<Vehicle> findByUser(User user);
    Vehicle findById(int vehicleId);
    List<Vehicle> findAll();
    public void update(Vehicle vehicle);
    List<Vehicle> findByUserId(int userId);
    boolean isVehicleNumberExists(String vehicleNumber);
}
