package com.yash.parkingallocation.dao;

import com.yash.parkingallocation.domain.Activity;
import java.util.List;

public interface ActivityDAO {
    void logActivity(Activity activity);
    List<Activity> getRecentActivities();
    void clearAllActivities();
}
