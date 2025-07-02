package com.yash.parkingallocation.service;

import com.razorpay.RazorpayException;
import com.yash.parkingallocation.domain.Payment;

import javax.servlet.http.HttpSession;

public interface PaymentService {
    String createOrder(int amount, String currency, String receipt, int slotId) throws RazorpayException;
    public boolean verifySignature(String orderId, String paymentId, String signature);
    Payment findByOrderId(String orderId);
    Payment findBySlotId(int slotId);
    public byte[] generateReceiptPdf(Payment payment);
    double getTotalRevenue();
}
