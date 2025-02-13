package com.yash.parkingallocation.dao;

import com.yash.parkingallocation.domain.Parking;

import java.util.List;

import com.yash.parkingallocation.rm.ParkingRowMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository
public class ParkingDAOImpl extends BaseDAO implements ParkingDAO {


    @Override
    public Parking save(Parking parking) {
        String sql = "INSERT INTO parking(slotNumber, slotStatus, allocationType, hourlyRate, dailyRate, duration, totalPrice, vehicleId, vehicleType, startTime, endTime, location)"
                + " VALUES(:slotNumber, :slotStatus, :allocationType, :hourlyRate, :dailyRate, :duration, :totalPrice, :vehicleId, :vehicleType, :startTime, :endTime, :location)";
        Map<String, Object> m = new HashMap<>();
        m.put("slotNumber", parking.getSlotNumber());
        m.put("slotStatus", parking.getSlotStatus());
        m.put("allocationType", parking.getAllocationType());
        m.put("hourlyRate", parking.getHourlyRate());
        m.put("dailyRate", parking.getDailyRate());
        m.put("duration", parking.getDuration());
        m.put("totalPrice", parking.getTotalPrice());
        m.put("vehicleId", parking.getVehicleId());
        m.put("vehicleType", parking.getVehicleType());
        m.put("startTime", parking.getStartTime());
        m.put("endTime", parking.getEndTime());
        m.put("location", parking.getLocation());

        SqlParameterSource ps = new MapSqlParameterSource(m);
        KeyHolder keyHolder = new GeneratedKeyHolder();
        super.getNamedParameterJdbcTemplate().update(sql, ps, keyHolder, new String[]{"slotId"});

        int generatedSlotId = keyHolder.getKey().intValue();
        parking.setSlotId(generatedSlotId);

        return parking;
    }

    @Override
    public void update(Parking parking) {
        String sql = "UPDATE parking SET slotNumber=:slotNumber, slotStatus=:slotStatus, allocationType=:allocationType, hourlyRate=:hourlyRate,"
                + " dailyRate=:dailyRate, duration=:duration, totalPrice=:totalPrice, vehicleId=:vehicleId, vehicleType=:vehicleType, startTime=:startTime, endTime=:endTime, location=:location WHERE slotId=:slotId";
        Map<String, Object> m = new HashMap<>();
        m.put("slotNumber", parking.getSlotNumber());
        m.put("slotStatus", parking.getSlotStatus());
        m.put("allocationType", parking.getAllocationType());
        m.put("hourlyRate", parking.getHourlyRate());
        m.put("dailyRate", parking.getDailyRate());
        m.put("duration", parking.getDuration());
        m.put("totalPrice", parking.getTotalPrice());
        m.put("vehicleId", parking.getVehicleId());
        m.put("vehicleType", parking.getVehicleType());
        m.put("startTime", parking.getStartTime());
        m.put("endTime", parking.getEndTime());
        m.put("location", parking.getLocation());
        m.put("slotId", parking.getSlotId());

        SqlParameterSource ps = new MapSqlParameterSource(m);
        super.getNamedParameterJdbcTemplate().update(sql, ps);

    }

    @Override
    public List<Parking> findAll() {
        String sql = "SELECT * FROM parking";
        return super.getNamedParameterJdbcTemplate().query(sql, new ParkingRowMapper());
    }

    @Override
    public Parking findById(int slotId) {
        String sql = "SELECT * FROM parking WHERE slotId = :slotId";
        SqlParameterSource ps = new MapSqlParameterSource("slotId", slotId);
        return super.getNamedParameterJdbcTemplate().queryForObject(sql, ps, new ParkingRowMapper());
    }

    @Override
    public List<Parking> findByVehicleId(int vehicleId) {
        String sql = "SELECT * FROM parking WHERE vehicleId = :vehicleId";
        SqlParameterSource ps = new MapSqlParameterSource("vehicleId", vehicleId);
        return super.getNamedParameterJdbcTemplate().query(sql, ps, new BeanPropertyRowMapper<>(Parking.class));
    }

    @Override
    public Parking findParkingByVehicleId(int vehicleId){
        String sql = "SELECT * FROM parking WHERE vehicleId = :vehicleId";
        SqlParameterSource ps = new MapSqlParameterSource("vehicleId", vehicleId);
        List<Parking> parkings = super.getNamedParameterJdbcTemplate().query(sql, ps, new ParkingRowMapper());
        if (parkings.isEmpty()) { System.out.println("No parking slots found for vehicle ID: " + vehicleId);
            return null;
        }
        else {
            System.out.println("Parking slot found for vehicle ID: " + vehicleId);
            return parkings.get(0);
        }
    }

    @Override
    public List<Parking> findByVehicleType(int vehicleType) {
        String sql = "SELECT * FROM parking WHERE vehicleType = :vehicleType";
        SqlParameterSource ps = new MapSqlParameterSource("vehicleType", vehicleType);
        return super.getNamedParameterJdbcTemplate().query(sql, ps, new ParkingRowMapper());
    }

    @Override public boolean isVehicleAlreadyBooked(int vehicleId) {
        String sql = "SELECT COUNT(*) FROM parking WHERE vehicleId = :vehicleId AND slotStatus = :slotStatus";
        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("vehicleId", vehicleId)
                .addValue("slotStatus", Parking.STATUS_RESERVED);
        Integer count = getNamedParameterJdbcTemplate().queryForObject(sql, params, Integer.class);
        return count != null && count > 0;
    }

    @Override
    public void delete(int slotId) {
        String sql = "DELETE FROM parking WHERE slotId = :slotId";
        SqlParameterSource ps = new MapSqlParameterSource("slotId",slotId);
        super.getNamedParameterJdbcTemplate().update(sql, ps);
    }

    @Override
    public int countActiveSlot() {
        String sql = "SELECT COUNT(*) FROM parking WHERE slotStatus = :slotStatus";
        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("slotStatus", Parking.STATUS_RESERVED);
        return getNamedParameterJdbcTemplate().queryForObject(sql, params, Integer.class);
    }

}

