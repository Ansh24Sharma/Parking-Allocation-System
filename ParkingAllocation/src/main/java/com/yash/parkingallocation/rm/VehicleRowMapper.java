package com.yash.parkingallocation.rm;

import com.yash.parkingallocation.domain.User;
import com.yash.parkingallocation.domain.Vehicle;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class VehicleRowMapper implements RowMapper<Vehicle> {
    @Override
    public Vehicle mapRow(ResultSet rs, int rowNum) throws SQLException {
        Vehicle vehicle = new Vehicle();
        vehicle.setVehicleId(rs.getInt("vehicleId"));
        vehicle.setChassisNumber(rs.getString("chassisNumber"));
        vehicle.setVehicleNumber(rs.getString("vehicleNumber"));
        vehicle.setVehicleType(rs.getInt("vehicleType"));

        // Assuming user details are fetched correctly
        User user = new User();
        user.setUserId(rs.getInt("userId"));
        user.setName(rs.getString("name")); // Ensure these columns exist
        user.setEmail(rs.getString("email")); // Ensure these columns exist
        vehicle.setUser(user);

        return vehicle;
    }
}
