package com.yash.parkingallocation.service;

import com.yash.parkingallocation.dao.ParkingDAO;
import com.yash.parkingallocation.domain.Parking;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Random;

@Service
public class ParkingServiceImpl implements ParkingService {

    @Autowired
    private ParkingDAO parkingDao;

    @Override
    public Parking save(Parking parking) {
        parkingDao.save(parking);
        return parking;
    }

    @Override
    public void update(Parking parking) {
        parkingDao.update(parking);
    }

    @Override
    public void delete(int slotId) { parkingDao.delete(slotId); }

    @Override
    public List<Parking> findAll() {
        return parkingDao.findAll();
    }

    @Override
    public Parking findById(int slotId) {
        return parkingDao.findById(slotId);
    }

    @Override
    public Parking findParkingByVehicleId(int vehicleId) {
        return parkingDao.findParkingByVehicleId(vehicleId);
    }

    @Override
    public List<Parking> findByVehicleId(int vehicleId) {
        return parkingDao.findByVehicleId(vehicleId);
    }

    @Override
    public void changeSlotStatus(int slotId, int newStatus) {
        Parking parking = parkingDao.findById(slotId);
        if (parking != null) {
            parking.setSlotStatus(newStatus);
            parkingDao.update(parking);
        }
    }

    @Override
    public int countAvailableSlots(int vehicleType) {
        List<Parking> parkings = parkingDao.findByVehicleType(vehicleType);
        int occupiedCount = 0;

        int totalSlots = vehicleType == 1 ? 20 : 30; // 20 for Two Wheeler, 30 for Four Wheeler
        int startSlot = vehicleType == 1 ? 1 : 21; // 1-20 for Two Wheelers, 21-50 for Four Wheelers

        //System.out.println("Total Slots: " + totalSlots);
        //System.out.println("Start Slot: " + startSlot);

        for (Parking parking : parkings) {
            //System.out.println("Parking slot found: " + parking.getSlotNumber() + ", Status: " + parking.getSlotStatus());
            if (parking.getSlotNumber() >= startSlot && parking.getSlotNumber() < startSlot + totalSlots) {
                if (parking.getSlotStatus() == Parking.STATUS_RESERVED) {
                    occupiedCount++;
                }
            }
        }

        int availableCount = totalSlots - occupiedCount;
        //System.out.println("Available Slots Counted: " + availableCount);
        //System.out.println("Occupied Slots Counted: " + occupiedCount);

        return availableCount; // Return the number of available slots
    }



    @Override
    public int generateUniqueSlotNumber(int vehicleType) {
        int totalSlots;
        int startSlot;

        if (vehicleType == 1) { // Two Wheeler
            totalSlots = 20;
            startSlot = 1;
        } else { // Four Wheeler
            totalSlots = 30;
            startSlot = 21;
        }

        List<Parking> parkings = parkingDao.findByVehicleType(vehicleType);
        boolean[] slots = new boolean[totalSlots];

        for (Parking parking : parkings) {
            if (parking.getVehicleType() == vehicleType && parking.getSlotNumber() >= startSlot && parking.getSlotNumber() < startSlot + totalSlots) {
                slots[parking.getSlotNumber() - startSlot] = true;
            }
        }

        Random random = new Random();
        for (int i = 0; i < totalSlots; i++) {
            int slotNumber = random.nextInt(totalSlots) + startSlot;
            if (!slots[slotNumber - startSlot]) {
                return slotNumber;
            }
        }
        return -1; // No available slot
    }

    @Override
    public boolean isVehicleAlreadyBooked(int vehicleId) {
        return parkingDao.isVehicleAlreadyBooked(vehicleId);
    }

    @Override
    public int getActiveSlot() {
        return parkingDao.countActiveSlot();
    }
}
