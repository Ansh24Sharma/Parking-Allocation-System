package com.yash.parkingallocation.service;

import com.yash.parkingallocation.dao.VehicleDAO;
import com.yash.parkingallocation.domain.User;
import com.yash.parkingallocation.domain.Vehicle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

@Service
public class VehicleServiceImpl implements VehicleService {

    @Autowired
    private VehicleDAO vehicleDao;

    @Override
    public void register(Vehicle vehicle) {
        vehicleDao.save(vehicle);
    }

    @Override
    public void delete(int vehicleId) {
        vehicleDao.delete(vehicleId);
    }

    @Override
    public List<Vehicle> findByUser(User user) {
        return vehicleDao.findByUser(user);
    }

    @Override
    public Vehicle findById(int vehicleId) {
        return vehicleDao.findById(vehicleId);
    }

    @Override
    public List<Vehicle> findAll() {
        return vehicleDao.findAll();
    }

    @Override
    public void update(Vehicle vehicle) {
        vehicleDao.update(vehicle);
    }

    @Override
    public List<Vehicle> findByUserId(int userId) {
        return vehicleDao.findByUserId(userId);
    }

    @Override
    public boolean isVehicleNumberExists(String vehicleNumber) {
        return vehicleDao.isVehicleNumberExists(vehicleNumber);
    }


}
