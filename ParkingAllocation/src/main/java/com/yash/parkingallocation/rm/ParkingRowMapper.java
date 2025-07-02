package com.yash.parkingallocation.rm;

import com.yash.parkingallocation.domain.Parking;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ParkingRowMapper implements RowMapper<Parking> {
    @Override
    public Parking mapRow(ResultSet rs, int rowNum) throws SQLException {
        Parking parking = new Parking();
        parking.setSlotId(rs.getInt("slotId"));
        parking.setSlotStatus(rs.getInt("slotStatus"));
        parking.setAllocationType(rs.getInt("allocationType"));
        parking.setHourlyRate(rs.getInt("hourlyRate"));
        parking.setDailyRate(rs.getInt("dailyRate"));
        parking.setDuration(rs.getInt("duration"));
        parking.setTotalPrice(rs.getInt("totalPrice"));
        parking.setVehicleType(rs.getInt("vehicleType"));
        parking.setVehicleId(rs.getInt("vehicleId"));
        parking.setSlotNumber(rs.getInt("slotNumber"));
        parking.setStartTime(rs.getTimestamp("startTime").toLocalDateTime());
        parking.setEndTime(rs.getTimestamp("endTime").toLocalDateTime());
        parking.setLocation(rs.getString("location"));
        return parking;
    }
}

