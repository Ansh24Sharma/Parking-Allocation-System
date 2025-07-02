package com.yash.parkingallocation.domain;

import java.time.LocalDateTime;

public class Parking {
    public static final int STATUS_AVAILABLE = 1;
    public static final int STATUS_RESERVED = 2;
    public static final int STATUS_PENDING_PAYMENT = 3;

    public static final int TYPE_HOURLY = 1;
    public static final int TYPE_DAILY = 2;

    private int slotId;
    private Integer vehicleId;
    private Integer slotStatus = STATUS_AVAILABLE;
    private Integer allocationType;
    private Integer hourlyRate = 10;
    private Integer dailyRate = 200;
    private Integer duration;
    private Integer totalPrice;
    private Integer vehicleType;
    private Integer slotNumber;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private String location;

    private String formattedStartTime;
    private String formattedEndTime;

    private Payment payment;
    private String allocationTypeString;
    private String durationString;

    public String getFormattedStartTime() {
        return formattedStartTime;
    }

    public void setFormattedStartTime(String formattedStartTime) {
        this.formattedStartTime = formattedStartTime;
    }

    public String getFormattedEndTime() {
        return formattedEndTime;
    }

    public void setFormattedEndTime(String formattedEndTime) {
        this.formattedEndTime = formattedEndTime;
    }

    public Integer getVehicleType() {
        return vehicleType;
    }

    public void setVehicleType(Integer vehicleType) {
        this.vehicleType = vehicleType;
    }

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }

    public LocalDateTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalDateTime endTime) {
        this.endTime = endTime;
    }

    public Integer getSlotNumber() {
        return slotNumber;
    }

    public void setSlotNumber(Integer slotNumber) {
        this.slotNumber = slotNumber;
    }

    public Integer getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(Integer vehicleId) {
        this.vehicleId = vehicleId;
    }

    public int getSlotId() {
        return slotId;
    }

    public void setSlotId(int slotId) {
        this.slotId = slotId;
    }


    public Integer getSlotStatus() {
        return slotStatus;
    }

    public void setSlotStatus(Integer slotStatus) {
        this.slotStatus = slotStatus;
    }

    public Integer getAllocationType() {
        return allocationType;
    }

    public void setAllocationType(Integer allocationType) {
        this.allocationType = allocationType;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public Integer getHourlyRate() {
        return hourlyRate;
    }

    public void setHourlyRate(Integer hourlyRate) {
        this.hourlyRate = hourlyRate;
    }

    public Integer getDailyRate() {
        return dailyRate;
    }

    public void setDailyRate(Integer dailyRate) {
        this.dailyRate = dailyRate;
    }

    public Integer getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Integer totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Payment getPayment() {
        return payment;
    }

    public void setPayment(Payment payment) {
        this.payment = payment;
    }

    public String getAllocationTypeString() {
        switch (allocationType) {
            case 1: return "Hourly";
            case 2: return "Daily";
            default: return "Unknown";
        }
    }

    public void setAllocationTypeString(String allocationTypeString) {
        this.allocationTypeString = allocationTypeString;
    }

    public String getDurationString() {
        if (allocationType == 1) {
            return duration + " hours";
        } else if (allocationType == 2) {
            if (duration == 1) {
                return "1 day"; }
            return duration + " days";
        } else {
            return "Unknown duration";
        }
    }

    public void setDurationString(String durationString) {
        this.durationString = durationString;
    }
}
