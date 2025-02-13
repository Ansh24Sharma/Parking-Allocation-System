package com.yash.parkingallocation.service;

import com.yash.parkingallocation.dao.ActivityDAO;
import com.yash.parkingallocation.domain.Activity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ActivityServiceImpl implements ActivityService {

    @Autowired
    private ActivityDAO activityDAO;

    @Override
    public void logActivity(String type, String description) {
        Activity activity = new Activity();
        activity.setType(type);
        activity.setDescription(description);
        activity.setTimestamp(LocalDateTime.now());
        activity.setUserId(activity.getUserId());
        activityDAO.logActivity(activity);
    }

    @Override
    public List<Activity> getRecentActivities() {
        return activityDAO.getRecentActivities();
    }

    @Override
    public void clearAllActivities() {
        activityDAO.clearAllActivities();
    }
}
