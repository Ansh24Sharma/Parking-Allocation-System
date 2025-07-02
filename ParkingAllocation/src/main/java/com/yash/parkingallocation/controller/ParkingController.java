package com.yash.parkingallocation.controller;

import com.yash.parkingallocation.domain.Parking;
import com.yash.parkingallocation.domain.Payment;
import com.yash.parkingallocation.domain.User;
import com.yash.parkingallocation.domain.Vehicle;
import com.yash.parkingallocation.service.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
public class ParkingController {

    @Autowired
    private ParkingService parkingService;

    @Autowired
    private VehicleService vehicleService;

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private ActivityService activityService;

    @RequestMapping(value = "/user/vehicle/bookSlot/{vehicleId}", method = RequestMethod.GET)
    public String showSlotAllocationForm(@PathVariable("vehicleId") int vehicleId, Model model) {
        Parking parking = new Parking();
        model.addAttribute("command", parking);
        model.addAttribute("vehicleId", vehicleId);
        return "slot_allocation"; // JSP
    }

    @RequestMapping(value = "/user/vehicle/allocateSlot", method = RequestMethod.POST)
    public String allocateSlot(@ModelAttribute("command") Parking parking, @RequestParam("vehicleId") int vehicleId, @RequestParam("startDateTime") String startDateTime, Model model, HttpSession session) {

        User loggedInUser = (User) session.getAttribute("user");
        if (session.getAttribute("userId") == null) {
            session.invalidate();
            return "redirect:/login";
        }


        Vehicle vehicle = vehicleService.findById(vehicleId);
        vehicle.setUser(loggedInUser);
        model.addAttribute("vehicle", vehicle);

        if (parkingService.isVehicleAlreadyBooked(vehicleId)) {
            model.addAttribute("vehicle", vehicle);
            return "redirect:/user/vehicle/details?act=abs";
        }


        parking.setVehicleId(vehicleId);
        parking.setVehicleType(vehicle.getVehicleType());


        int availableSlots = parkingService.countAvailableSlots(parking.getVehicleType());
        if (availableSlots <= 0) {
            model.addAttribute("message", "No slots available for the selected vehicle type.");
            return "redirect:/user/vehicle/details"; // Redirect to vehicle details
        }

        if (parking.getAllocationType() == Parking.TYPE_HOURLY) {
            parking.setTotalPrice(parking.getHourlyRate() * parking.getDuration());
        } else if (parking.getAllocationType() == Parking.TYPE_DAILY) {
            parking.setTotalPrice(parking.getDailyRate() * parking.getDuration());
        }

        int slotNumber = parkingService.generateUniqueSlotNumber(parking.getVehicleType());
        if (slotNumber == -1) {
            model.addAttribute("message", "No available slots.");
            return "redirect:/user/vehicle/details"; // Redirect to vehicle details
        }

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        LocalDateTime startTime = LocalDateTime.parse(startDateTime, formatter);
        parking.setStartTime(startTime);
        LocalDateTime endTime;
        if (parking.getAllocationType() == Parking.TYPE_HOURLY) {
            endTime = startTime.plusHours(parking.getDuration());
        }
        else {
            endTime = startTime.plusDays(parking.getDuration());
        }
        parking.setEndTime(endTime);

        DateTimeFormatter displayFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm a");
        model.addAttribute("formattedStartTime", startTime.format(displayFormatter));
        model.addAttribute("formattedEndTime", endTime.format(displayFormatter));

        parking.setSlotNumber(slotNumber); // Assign the unique slot number
        parking.setSlotStatus(Parking.STATUS_PENDING_PAYMENT); // Set status to payment pending
        Parking savedParking = parkingService.save(parking);

        session.setAttribute("slotId", savedParking.getSlotId());
        session.setAttribute("vehicleId", vehicleId);
        session.setAttribute("startDateTime", startDateTime);

        System.out.println("Slot ID stored in session: " + parking.getSlotId());


        model.addAttribute("slot", parking); // Add slot details to model
        activityService.logActivity("New Booking", loggedInUser.getName() + " created a booking for slot: " + parking.getSlotNumber());
        return "slot_details"; // Redirect to slot details page
    }

    @RequestMapping(value = "/user/vehicle/viewSlot/{slotId}", method = RequestMethod.GET)
    public String viewSlotDetails(@PathVariable("slotId") int slotId, Model model, HttpSession session) {
        Parking parking = parkingService.findById(slotId);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss a");
        model.addAttribute("formattedStartTime", parking.getStartTime().format(formatter));
        model.addAttribute("formattedEndTime", parking.getEndTime().format(formatter));

        session.setAttribute("slotId", parking.getSlotId());

        model.addAttribute("slot", parking);
        return "slot_details"; // JSP
    }

    @RequestMapping(value = "/checkSlotAvailability", method = RequestMethod.GET)
    @ResponseBody
    public String checkSlotAvailability(@RequestParam("vehicleType") int vehicleType) {
        int totalSlots = getTotalSlots(vehicleType);
        int availableSlots = parkingService.countAvailableSlots(vehicleType);
        int occupiedSlots = totalSlots - availableSlots;

        /*System.out.println("Vehicle Type: " + vehicleType);
        System.out.println("Total Slots: " + totalSlots);
        System.out.println("Available Slots: " + availableSlots);
        System.out.println("Occupied Slots: " + occupiedSlots);*/

        return occupiedSlots + " slots occupied and " + availableSlots + " slots are available";
    }
    private int getTotalSlots(int vehicleType) {
        if (vehicleType == 1) {
            return 20;
        } else {
            return 30;
        }
    }

    @RequestMapping(value = "/user/vehicle/deleteSlot", method = RequestMethod.GET)
    public String deleteSlot(@RequestParam("slotId") int slotId) {
        parkingService.delete(slotId);
        return "redirect:/user/vehicle/details?act=sld";
    }

    @RequestMapping(value = "user/parking/bookings", method = RequestMethod.GET)
    public String viewBookings(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("user");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm a");
        List<Vehicle> vehicles = vehicleService.findByUserId(loggedInUser.getUserId());

        for (Vehicle vehicle : vehicles) {
            vehicle.setVehicleTypeString(vehicle.getVehicleTypeString());
            List<Parking> parkings = parkingService.findByVehicleId(vehicle.getVehicleId());
            for (Parking parking : parkings) {
                parking.setFormattedStartTime(formatter.format(parking.getStartTime()));
                parking.setFormattedEndTime(formatter.format(parking.getEndTime()));
                parking.setDurationString(parking.getDurationString());
                parking.setAllocationTypeString(parking.getAllocationTypeString());

                Payment payment = paymentService.findBySlotId(parking.getSlotId());
                parking.setPayment(payment);
            }
            vehicle.setParkings(parkings);
        }

        model.addAttribute("vehicles", vehicles);
        return "view_bookings";
    }
}



