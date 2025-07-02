package com.yash.parkingallocation.controller;

import com.yash.parkingallocation.command.VehicleCommand;
import com.yash.parkingallocation.domain.Parking;
import com.yash.parkingallocation.domain.User;
import com.yash.parkingallocation.domain.Vehicle;
import com.yash.parkingallocation.service.ActivityService;
import com.yash.parkingallocation.service.ParkingService;
import com.yash.parkingallocation.service.VehicleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.MediaType;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.List;


@Controller
public class VehicleController {

    @Autowired
    private VehicleService vehicleService;

    @Autowired
    private ParkingService parkingService;

    @Autowired
    private ActivityService activityService;

    @RequestMapping(value = "/user/dashboard", method = RequestMethod.GET)
    public String showDashboard(Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            session.invalidate();
            return "redirect:/index";
        }
        VehicleCommand vehicleCommand = new VehicleCommand();
        model.addAttribute("command", vehicleCommand);
        User loggedInUser = (User) session.getAttribute("user");
        model.addAttribute("vehicles", vehicleService.findByUser(loggedInUser));
        return "dashboard_user"; // JSP
    }

    @RequestMapping(value = "/user/vehicle/register", method = RequestMethod.GET)
    public String showRegisterVehicleForm(Model model) {
        model.addAttribute("command", new VehicleCommand());
        return "vehicle_register";
    } // This should correspond to vehicle_register.jsp

    @RequestMapping(value = "/user/vehicle/register", method = RequestMethod.POST)
    public String registerVehicle(@ModelAttribute("command") VehicleCommand cmd, HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("user");
        if (session.getAttribute("userId") == null) {
            session.invalidate();
            return "redirect:/login";
        }
        Vehicle vehicle = cmd.getVehicle();
        vehicle.setUser(loggedInUser);

        if (vehicleService.isVehicleNumberExists(vehicle.getVehicleNumber())) {
            model.addAttribute("errorMessage", "Vehicle number already exists. Please use a different vehicle number.");
            return "vehicle_register";
        }
        vehicleService.register(vehicle);
        session.setAttribute("message", "Your vehicle has been registered successfully!");
        activityService.logActivity("Vehicle Registered", loggedInUser.getName() + " registered vehicle with number: " + vehicle.getVehicleNumber());
        return "redirect:/user/vehicle/details?act=vrs";
    }


    @RequestMapping(value = "/user/vehicle/details", method = RequestMethod.GET)
    public String showVehicleDetails(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("user");
        List<Vehicle> vehicles = vehicleService.findByUser(loggedInUser);
        for (Vehicle vehicle : vehicles) {
            Parking parking = parkingService.findParkingByVehicleId(vehicle.getVehicleId());
            /*if (parking != null) {
                System.out.println("Parking slot found for vehicle ID: " + vehicle.getVehicleId());
            } else {
                System.out.println("No parking slot found for vehicle ID: " + vehicle.getVehicleId());
            }*/
            vehicle.setParking(parking);
        }
        model.addAttribute("vehicles", vehicles);
        return "vehicle_details"; // JSP
    }


    @RequestMapping(value = "/user/vehicle/update", method = RequestMethod.GET)
    public String showUpdateVehicleForm(@RequestParam("vehicleId") int vehicleId, Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("user");
        Vehicle vehicle = vehicleService.findById(vehicleId);
        if (vehicle.getUser().getUserId() != loggedInUser.getUserId()) {
            return "redirect:/user/vehicle/details";
        }
        VehicleCommand vehicleCommand = new VehicleCommand();
        vehicleCommand.setVehicle(vehicle);
        model.addAttribute("command", vehicleCommand);
        return "vehicle_update"; // JSP for vehicle update
    }

    @RequestMapping(value = "/user/vehicle/update", method = RequestMethod.POST)
    public String updateVehicle(@ModelAttribute("command") VehicleCommand cmd, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("user");
        Vehicle vehicle = cmd.getVehicle();
        vehicle.setUser(loggedInUser);

        vehicleService.update(vehicle);
        session.setAttribute("message", "Your vehicle details has been updated successfully!");

        return "redirect:/user/vehicle/details?act=upd";
    }

    @RequestMapping(value = "/user/vehicle/slotDetails", method = RequestMethod.GET)
    public String slotDetails(@RequestParam("vehicleId") int vehicleId, Model model) {
        Parking parking = parkingService.findParkingByVehicleId(vehicleId);
        if (parking != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss a");
            model.addAttribute("formattedStartTime", parking.getStartTime().format(formatter));
            model.addAttribute("formattedEndTime", parking.getEndTime().format(formatter));
            model.addAttribute("slot", parking);
        } return "slot_details";
    }

    @RequestMapping(value = "/user/vehicle/delete", method = RequestMethod.GET)
    public String deleteVehicle(@RequestParam("vehicleId") int vehicleId, HttpSession session) {
        // Check if user is authenticated
        if (session.getAttribute("userId") == null) {
            session.invalidate();
            return "redirect:/login";
        }

        vehicleService.delete(vehicleId);
        return "redirect:/user/vehicle/details?act=del"; // Redirect to vehicle details page after deletion
    }


}
/*@GetMapping("/user/vehicle/export")
    public ResponseEntity<ByteArrayResource> exportVehiclesToExcel(HttpSession session) throws IOException {
        User loggedInUser = (User) session.getAttribute("user");
        List<Vehicle> vehicles = vehicleService.findByUser(loggedInUser);
        byte[] data = vehicleService.exportToExcel(vehicles);
        ByteArrayResource resource = new ByteArrayResource(data);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=vehicles.xlsx")
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .contentLength(data.length)
                .body(resource);
    }*/