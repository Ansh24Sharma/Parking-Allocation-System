package com.yash.parkingallocation.service;

import com.yash.parkingallocation.domain.User;
import com.yash.parkingallocation.domain.Vehicle;

import java.io.IOException;
import java.util.List;

public interface VehicleService {

    void register(Vehicle vehicle);
    void delete (int vehicleId);
    List<Vehicle> findByUser(User user);
    Vehicle findById(int vehicleId);
    List<Vehicle> findAll();
    void update(Vehicle vehicle);
    List<Vehicle> findByUserId(int userId);
    boolean isVehicleNumberExists(String vehicleNumber);
}
