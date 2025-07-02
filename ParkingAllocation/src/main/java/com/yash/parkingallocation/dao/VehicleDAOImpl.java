package com.yash.parkingallocation.dao;

import com.yash.parkingallocation.domain.User;
import com.yash.parkingallocation.domain.Vehicle;
import com.yash.parkingallocation.rm.VehicleRowMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class VehicleDAOImpl extends BaseDAO implements VehicleDAO {

    @Override
    public void save(Vehicle vehicle) {
        String sql = "INSERT INTO vehicle(vehicleNumber, chassisNumber, vehicleType, userId)"
                + " VALUES(:vehicleNumber, :chassisNumber, :vehicleType, :userId)";
        Map<String, Object> m = new HashMap<>();
        m.put("vehicleNumber", vehicle.getVehicleNumber());
        m.put("vehicleType", vehicle.getVehicleType());
        m.put("userId", vehicle.getUser().getUserId());
        m.put("chassisNumber", vehicle.getChassisNumber());

        SqlParameterSource ps = new MapSqlParameterSource(m);
        super.getNamedParameterJdbcTemplate().update(sql, ps);
    }

    @Override
    public List<Vehicle> findByUser(User user) {
        String sql = "SELECT v.*, u.name, u.email FROM vehicle v "
                + "JOIN user u ON v.userId = u.userId WHERE v.userId = :userId";
        SqlParameterSource ps = new MapSqlParameterSource("userId", user.getUserId());
        return super.getNamedParameterJdbcTemplate().query(sql, ps, new VehicleRowMapper());
    }

    @Override
    public Vehicle findById(int vehicleId) {
            String sql = "SELECT v.*, u.name, u.email FROM vehicle v " +
                    "JOIN user u ON v.userId = u.userId WHERE v.vehicleId = :vehicleId";
            SqlParameterSource ps = new MapSqlParameterSource("vehicleId", vehicleId);
            return super.getNamedParameterJdbcTemplate().queryForObject(sql, ps, new VehicleRowMapper());
    }

    @Override public List<Vehicle> findAll() {
        String sql = "SELECT v.*, u.name, u.email FROM vehicle v " +
                "JOIN user u ON v.userId = u.userId";
        return super.getNamedParameterJdbcTemplate().query(sql, new VehicleRowMapper());
    }

    @Override
    public void update(Vehicle vehicle) {
        String sql = "UPDATE vehicle SET vehicleNumber = :vehicleNumber, chassisNumber = :chassisNumber, vehicleType = :vehicleType WHERE vehicleId = :vehicleId";
        Map<String, Object> m = new HashMap<>();
        m.put("vehicleNumber", vehicle.getVehicleNumber());
        m.put("vehicleType", vehicle.getVehicleType());
        m.put("vehicleId", vehicle.getVehicleId());
        m.put("chassisNumber", vehicle.getChassisNumber());

        SqlParameterSource ps = new MapSqlParameterSource(m);
        super.getNamedParameterJdbcTemplate().update(sql, ps);
    }

    @Override
    public List<Vehicle> findByUserId(int userId) {
        String sql = "SELECT * FROM vehicle WHERE userId = :userId";
        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("userId", userId);
        return super.getNamedParameterJdbcTemplate().query(sql, params, new BeanPropertyRowMapper<>(Vehicle.class));
    }

    @Override
    public boolean isVehicleNumberExists(String vehicleNumber) {
        String sql = "SELECT COUNT(*) FROM vehicle WHERE vehicleNumber = :vehicleNumber";
        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("vehicleNumber", vehicleNumber);
        Integer count = getNamedParameterJdbcTemplate().queryForObject(sql, params, Integer.class);
        return count != null && count > 0;
    }

    @Override
    public void delete(int vehicleId) {
        String sql = "DELETE FROM vehicle WHERE vehicleId = :vehicleId";
        SqlParameterSource ps = new MapSqlParameterSource("vehicleId",vehicleId);
        super.getNamedParameterJdbcTemplate().update(sql, ps);
    }
}

