package com.yash.parkingallocation.controller;

import com.yash.parkingallocation.command.PaymentCommand;
import com.yash.parkingallocation.domain.Parking;
import com.yash.parkingallocation.domain.Payment;
import com.yash.parkingallocation.service.ParkingService;
import com.yash.parkingallocation.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private ParkingService parkingService;

    private final String razorpayKeyId = "rzp_test_BZSOgBnXQoiSLs"; // Hardcoded Razorpay Key ID

    @GetMapping("/checkout")
    public String showCheckoutPage(Model model) {
        model.addAttribute("razorpayKeyId", razorpayKeyId);
        return "redirect:index?act=pf"; // Redirect to the index page with action parameter
    }

    @GetMapping("/create-order")
    public String createOrder(@ModelAttribute("command") PaymentCommand cmd, @RequestParam("slotId") int slotId, Model model, HttpSession session) {
        System.out.println("Inside create order method!");

        int amount = cmd.getAmount();
        Integer userId = (Integer) session.getAttribute("userId");

        // Check if user is logged in
        if (userId == null) {
            session.setAttribute("Amount", amount);
            return "redirect:login"; // Redirect to login if user is not logged in
        }

        try {
            System.out.println("Amount: " + amount);
            session.setAttribute("amount", amount); // Store amount in session
            session.setAttribute("slotId", slotId);
            String orderId = paymentService.createOrder(amount, "INR", "receipt_" + System.currentTimeMillis(), slotId);

            // Add necessary attributes for the payment page
            model.addAttribute("paymentId", orderId);
            model.addAttribute("amount", amount);
            model.addAttribute("razorpayKeyId", razorpayKeyId);
            model.addAttribute("currency", "INR");

            // Debug information
            System.out.println("Order created with ID: " + orderId);
            System.out.println("Amount: " + amount);
            System.out.println("Key ID: " + razorpayKeyId);
            System.out.println("Slot ID stored in session: " + slotId);

            return "payment"; // Return the payment view
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error creating order: " + e.getMessage());
            return "error"; // Return error view
        }
    }

    @PostMapping("/verify")
    public String verifyPayment(
            @RequestParam String razorpay_order_id,
            @RequestParam String razorpay_payment_id,
            @RequestParam String razorpay_signature,
            Model model, HttpSession session) {

        System.out.println("Verifying payment...");
        System.out.println("Order ID: " + razorpay_order_id);
        System.out.println("Payment ID: " + razorpay_payment_id);

        // Verify the payment signature
        boolean isValid = paymentService.verifySignature(
                razorpay_order_id,
                razorpay_payment_id,
                razorpay_signature
        );

        if (isValid) {
            Integer slotId = (Integer) session.getAttribute("slotId");
            System.out.println("Slot ID retrieved from session: " + slotId);
            if (slotId == null) {
                return "redirect:/index?act=pf"; // Redirect to index on failure
            }
            Parking parking = parkingService.findById(slotId);
            parking.setSlotStatus(Parking.STATUS_RESERVED);
            parkingService.update(parking);

            Payment payment = paymentService.findByOrderId(razorpay_order_id);

            // Add payment details to the model
            model.addAttribute("orderId", payment.getOrderId());
            model.addAttribute("amount", payment.getAmount());
            model.addAttribute("currency", payment.getCurrency());
            model.addAttribute("receipt", payment.getReceipt());
            model.addAttribute("slotId", payment.getSlotId());
            model.addAttribute("createdAt", payment.getCreatedAt());

            session.removeAttribute("slotId");
            session.removeAttribute("vehicleId");
            session.removeAttribute("startDateTime");

            return "success_pay"; // Redirect to success page
        } else {
            return "redirect:index?act=pf"; // Redirect to index on failure
        }
    }

    @GetMapping("/user/vehicle/receipt")
    public String viewReceipt(@RequestParam("slotId") int slotId, Model model) {
        // Retrieve payment details using vehicleId
        Payment payment = paymentService.findBySlotId(slotId);
        if (payment == null) {
            model.addAttribute("error", "No payment found for the given vehicle ID");
            return "error"; // Return error view if no payment found
        }

        // Add payment details to the model
        model.addAttribute("orderId", payment.getOrderId());
        model.addAttribute("amount", payment.getAmount());
        model.addAttribute("currency", payment.getCurrency());
        model.addAttribute("receipt", payment.getReceipt());
        model.addAttribute("slotId", payment.getSlotId());
        model.addAttribute("createdAt", payment.getCreatedAt());

        return "receipt"; // Forward to receipt.jsp
    }

    @GetMapping("/downloadReceipt")
    public void downloadReceipt(@RequestParam("slotId") int slotId, HttpServletResponse response) {
        try {
            Payment payment = paymentService.findBySlotId(slotId);
            byte[] pdfBytes = paymentService.generateReceiptPdf(payment);

            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=receipt.pdf");
            response.getOutputStream().write(pdfBytes);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
