package com.yash.parkingallocation.rm;

import com.yash.parkingallocation.domain.Activity;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ActivityRowMapper implements RowMapper<Activity> {

    @Override
    public Activity mapRow(ResultSet rs, int rowNum) throws SQLException {
        Activity activity = new Activity();
        activity.setId(rs.getInt("id"));
        activity.setType(rs.getString("type"));
        activity.setDescription(rs.getString("description"));
        activity.setTimestamp(rs.getTimestamp("timestamp").toLocalDateTime());
        return activity;
    }
}
