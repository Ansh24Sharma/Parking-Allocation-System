package com.yash.parkingallocation.rm;

import com.yash.parkingallocation.domain.Parking;
import com.yash.parkingallocation.domain.Payment;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class PaymentRowMapper implements RowMapper<Payment> {
    @Override
    public Payment mapRow(ResultSet rs, int rowNum) throws SQLException {
        Payment payment = new Payment();
        payment.setId(rs.getInt("id"));
        payment.setOrderId(rs.getString("orderId"));
        payment.setAmount(rs.getInt("amount"));
        payment.setCurrency(rs.getString("currency"));
        payment.setSlotId(rs.getInt("slotId"));
        payment.setReceipt(rs.getString("receipt"));
        payment.setCreatedAt(rs.getTimestamp("createdAt").toLocalDateTime());

        return payment;
    }
}
