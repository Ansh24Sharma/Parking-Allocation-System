package com.yash.parkingallocation.dao;

import com.yash.parkingallocation.domain.Activity;
import com.yash.parkingallocation.rm.ActivityRowMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ActivityDAOImpl extends BaseDAO implements ActivityDAO{

    @Override
    public void logActivity(Activity activity) {
        String sql = "INSERT INTO activity(type, description, timestamp) VALUES (:type, :description, :timestamp)";

        Map<String, Object> m = new HashMap<>();
        m.put("type", activity.getType());
        m.put("description", activity.getDescription());
        m.put("timestamp", activity.getTimestamp());
        m.put("userId", activity.getUserId());

        SqlParameterSource ps = new MapSqlParameterSource(m);
        KeyHolder keyHolder = new GeneratedKeyHolder();
        super.getNamedParameterJdbcTemplate().update(sql, ps, keyHolder);
    }

    @Override
    public List<Activity> getRecentActivities() {
        String sql = "SELECT * FROM activity ORDER BY timestamp DESC LIMIT 10";
        return getNamedParameterJdbcTemplate().query(sql, new ActivityRowMapper());
    }

    @Override
    public void clearAllActivities() {
        String sql = "DELETE FROM activity";
        getNamedParameterJdbcTemplate().update(sql, new MapSqlParameterSource());
    }
}
