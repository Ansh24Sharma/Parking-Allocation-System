package com.yash.parkingallocation.dao;

import com.yash.parkingallocation.domain.Parking;

import java.util.List;

public interface ParkingDAO {
    Parking save(Parking slot);
    void update(Parking slot);
    void delete(int slotId);
    List<Parking> findAll();
    Parking findById(int slotId);
    Parking findParkingByVehicleId(int vehicleId);
    List<Parking> findByVehicleId(int vehicleId);
    List<Parking> findByVehicleType(int vehicleType);
    boolean isVehicleAlreadyBooked(int vehicleId);
    int countActiveSlot();
}
