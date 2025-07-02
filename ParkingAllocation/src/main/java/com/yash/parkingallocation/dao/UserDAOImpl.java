package com.yash.parkingallocation.dao;

import com.yash.parkingallocation.domain.Parking;
import com.yash.parkingallocation.domain.User;
import com.yash.parkingallocation.domain.Vehicle;
import com.yash.parkingallocation.rm.ParkingRowMapper;
import com.yash.parkingallocation.rm.UserRowMapper;
import com.yash.parkingallocation.rm.VehicleRowMapper;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class UserDAOImpl extends BaseDAO implements UserDAO {


    @Override
    public void save(User user) {
        String sql = "INSERT INTO user(name, phone, email, loginName, password, role, loginStatus)"
                + " VALUES(:name, :phone, :email, :loginName, :password, :role, :loginStatus)";
        Map m = new HashMap();
        m.put("name", user.getName());
        m.put("phone", user.getPhone());
        m.put("email", user.getEmail());
        m.put("loginName", user.getLoginName());
        m.put("password", user.getPassword());
        m.put("role", user.getRole());
        m.put("loginStatus", user.getLoginStatus());

        KeyHolder kh = new GeneratedKeyHolder();
        SqlParameterSource ps = new MapSqlParameterSource(m);
        super.getNamedParameterJdbcTemplate().update(sql, ps, kh);
        Integer userId = kh.getKey().intValue();
        user.setUserId(userId);
    }

    @Override
    public void update(User user) {
        String sql = "UPDATE user "
                + " SET name=:name,"
                + " phone=:phone, "
                + " email=:email,"

                + " role=:role,"
                + " loginStatus=:loginStatus "
                + " WHERE userId=:userId";
        Map m = new HashMap();
        m.put("name", user.getName());
        m.put("phone", user.getPhone());
        m.put("email", user.getEmail());

        m.put("role", user.getRole());
        m.put("loginStatus", user.getLoginStatus());
        m.put("userId", user.getUserId());
        getNamedParameterJdbcTemplate().update(sql, m);
    }

    @Override
    public void delete(User user) {
        this.delete(user.getUserId());
    }

    @Override
    public void delete(Integer userId) {
        String sql="DELETE FROM user WHERE userId=?";
        getJdbcTemplate().update(sql, userId);
    }


    @Override
    public User findById(Integer userId) {
        String sql = "SELECT userId, name, phone, email, loginName, role, loginStatus"
                + " FROM user WHERE userId=?";
        User u = getJdbcTemplate().queryForObject(sql, new UserRowMapper(),userId);
        List<Vehicle> vehicles = findVehiclesByUserId(userId);
        u.setVehicles(vehicles);
        return u;

    }

    @Override
    public List<User> findAllUsers() {
        String sql = "SELECT * FROM user";
        return super.getNamedParameterJdbcTemplate().query(sql, new BeanPropertyRowMapper<>(User.class));
    }

    @Override
    public List<User> findByProperty(String propName, Object propValue) {
        String sql = "SELECT userId, name, phone, email, loginName, role, loginStatus"
                + " FROM user WHERE "+propName+"=?";
        return getJdbcTemplate().query(sql, new UserRowMapper(), propValue);

    }

    @Override public List<Vehicle> findVehiclesByUserId(int userId) {
        String sql = "SELECT * FROM vehicle WHERE userId = :userId";
        SqlParameterSource ps = new MapSqlParameterSource("userId", userId);
        return getNamedParameterJdbcTemplate().query(sql, ps, new VehicleRowMapper());
    }

    @Override public List<Parking> findParkingByVehicleId(int vehicleId) {
        String sql = "SELECT * FROM parking WHERE vehicleId = :vehicleId";
        SqlParameterSource ps = new MapSqlParameterSource("vehicleId", vehicleId);
        return getNamedParameterJdbcTemplate().query(sql, ps, new ParkingRowMapper());
    }

    @Override
    public int countUsers() {
        String sql = "SELECT COUNT(*) FROM user";
        return getJdbcTemplate().queryForObject(sql, Integer.class);
    }


    @Override
    public List<Map<String, Object>> findDetailedReports() {
        String sql = "SELECT u.name, v.vehicleType, p.allocationType, p.slotNumber, pay.amount, pay.createdAt " +
                "FROM user u " +
                "JOIN vehicle v ON u.userId = v.userId " +
                "JOIN parking p ON v.vehicleId = p.vehicleId " +
                "JOIN payment pay ON p.slotId = pay.slotId";

        List<Map<String, Object>> reports = getNamedParameterJdbcTemplate().queryForList(sql, new MapSqlParameterSource());

        for (Map<String, Object> report : reports) {
            Vehicle vehicle = new Vehicle();
            vehicle.setVehicleType((Integer) report.get("vehicleType"));
            Parking parking = new Parking();
            parking.setAllocationType((Integer) report.get("allocationType"));

            report.put("vehicleTypeString", vehicle.getVehicleTypeString());
            report.put("allocationTypeString", parking.getAllocationTypeString());
        }

        return reports;
    }
}
