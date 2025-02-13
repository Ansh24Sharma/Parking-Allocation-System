package com.yash.parkingallocation.service;

import com.yash.parkingallocation.domain.Parking;

import java.util.List;

public interface ParkingService {
    Parking save(Parking parking);
    void update(Parking parking);
    void delete(int slotId);
    List<Parking> findAll();
    Parking findById(int slotId);
    Parking findParkingByVehicleId(int vehicleId);
    List<Parking> findByVehicleId(int vehicleId);
    int countAvailableSlots(int vehicleType);
    void changeSlotStatus(int slotId, int newStatus);
    int generateUniqueSlotNumber(int vehicleType);
    boolean isVehicleAlreadyBooked(int vehicleId);
    int getActiveSlot();
}

