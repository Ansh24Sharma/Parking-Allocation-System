package com.yash.parkingallocation.domain;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Activity {
    private int id;
    private String type; // e.g., "New User", "New Booking", "Vehicle Registered"
    private String description;
    private LocalDateTime timestamp;
    private Integer userId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getFormattedTimestamp() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("hh:mm a");
        return this.timestamp.format(formatter);
    }
}
