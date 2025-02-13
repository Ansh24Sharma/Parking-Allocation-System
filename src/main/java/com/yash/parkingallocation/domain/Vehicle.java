package com.yash.parkingallocation.domain;

import java.util.List;

public class Vehicle {
    private Integer vehicleId;
    private String vehicleNumber;
    private Integer vehicleType; // 1 for two wheeler, 2 for four wheeler
    private String chassisNumber;
    private User user; // The user who owns this vehicle
    private List<Parking> parkings;
    private Parking parking;
    private String vehicleTypeString;

    public Parking getParking() {
        return parking;
    }

    public void setParking(Parking parking) {
        this.parking = parking;
    }

    public Integer getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(Integer vehicleId) {
        this.vehicleId = vehicleId;
    }

    public List<Parking> getParkings() {
        return parkings;
    }

    public void setParkings(List<Parking> parkings) {
        this.parkings = parkings;
    }

    public String getVehicleNumber() {
        return vehicleNumber;
    }

    public void setVehicleNumber(String vehicleNumber) {
        this.vehicleNumber = vehicleNumber;
    }

    public String getChassisNumber() {
        return chassisNumber;
    }

    public void setChassisNumber(String chassisNumber) {
        this.chassisNumber = chassisNumber;
    }

    public Integer getVehicleType() {
        return vehicleType;
    }

    public void setVehicleType(Integer vehicleType) {
        this.vehicleType = vehicleType;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getVehicleTypeString() {
        switch (vehicleType) {
            case 1: return "Two Wheeler";
            case 2: return "Four Wheeler";
            default: return "Unknown";
        }
    }

    public void setVehicleTypeString(String vehicleTypeString) {
        this.vehicleTypeString = vehicleTypeString;
    }
}

