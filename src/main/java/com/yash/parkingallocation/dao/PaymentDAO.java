package com.yash.parkingallocation.dao;

import com.yash.parkingallocation.domain.Payment;

import java.util.List;

public interface PaymentDAO {
    Payment save(Payment payment);
    Payment findById(int id);
    List<Payment> findAll();
    Payment findByOrderId(String orderId);
    Payment findBySlotId(int slotId);
    double totalRevenue();
}