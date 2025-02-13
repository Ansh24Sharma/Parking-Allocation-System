package com.yash.parkingallocation.service;

import com.yash.parkingallocation.domain.Activity;
import java.util.List;

public interface ActivityService {
    void logActivity(String type, String description);
    List<Activity> getRecentActivities();
    void clearAllActivities();
}
