package com.yash.parkingallocation.controller;

import java.time.format.DateTimeFormatter;
import java.util.List;

import com.yash.parkingallocation.domain.Activity;
import com.yash.parkingallocation.domain.Parking;
import com.yash.parkingallocation.domain.User;
import com.yash.parkingallocation.domain.Vehicle;
import com.yash.parkingallocation.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.format.DateTimeFormatter;
import java.util.Map;


@Controller
public class AdminController {

    @Autowired
    private UserService userService;

    @Autowired
    private VehicleService vehicleService;

    @Autowired
    private ParkingService parkingService;

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private ActivityService activityService;

    @RequestMapping(value = "/admin/dashboard", method = RequestMethod.GET)
    public String viewDashboard( Model model) {
        int totalUsers = userService.getTotalUsers();
        int activeBooking = parkingService.getActiveSlot();
        double totalRevenue = paymentService.getTotalRevenue();
        int availableTwoWheelerSlots = parkingService.countAvailableSlots(1);
        int availableFourWheelerSlots = parkingService.countAvailableSlots(2);

        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("activeBooking", activeBooking);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("availableTwoWheelerSlots", availableTwoWheelerSlots);
        model.addAttribute("availableFourWheelerSlots", availableFourWheelerSlots);

        List<Activity> recentActivities = activityService.getRecentActivities();
        model.addAttribute("recentActivities", recentActivities);


        return "dashboard_admin";
    }

    @RequestMapping(value = "/admin/viewReports", method = RequestMethod.GET)
    public String viewReports(Model model) {
        List<User> users = userService.findAllUsers();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm a");

        // Fetch vehicles and parking details for each user
        for (User user : users) {
            List<Vehicle> vehicles = vehicleService.findByUserId(user.getUserId());
            for (Vehicle vehicle : vehicles) {
                List<Parking> parkings = parkingService.findByVehicleId(vehicle.getVehicleId());
                for (Parking parking : parkings) {
                    parking.setFormattedStartTime(formatter.format(parking.getStartTime()));
                    parking.setFormattedEndTime(formatter.format(parking.getEndTime()));
                }
                vehicle.setParkings(parkings);
            }
            user.setVehicles(vehicles);
        }

        model.addAttribute("users", users);
        return "view_reports";
    }

    @RequestMapping(value = "/admin/clear-activities", method = RequestMethod.POST)
    public String clearActivities(Model model) {
        activityService.clearAllActivities();
        return "redirect:/admin/dashboard";
    }

    @RequestMapping(value = "/admin/bookings", method = RequestMethod.GET)
    public String viewDetailedReports(Model model) {
        List<Map<String, Object>> reports = userService.getDetailedReports();
        model.addAttribute("reports", reports);
        return "detailed_reports";
    }
}
