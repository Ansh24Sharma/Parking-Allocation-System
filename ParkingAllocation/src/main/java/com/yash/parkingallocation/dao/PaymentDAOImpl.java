package com.yash.parkingallocation.dao;

import com.yash.parkingallocation.domain.Payment;
import com.yash.parkingallocation.rm.PaymentRowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class PaymentDAOImpl extends BaseDAO implements PaymentDAO {

    @Override
    public Payment save(Payment payment) {
        String sql = "INSERT INTO payment(orderId, amount, currency, slotId, receipt, createdAt)"
                + "VALUES(:orderId, :amount, :currency, :slotId, :receipt, :createdAt)";

        Map<String, Object> m = new HashMap<>();
        m.put("orderId", payment.getOrderId());
        m.put("amount", payment.getAmount());
        m.put("currency", payment.getCurrency());
        m.put("slotId", payment.getSlotId());
        m.put("receipt", payment.getReceipt());
        m.put("createdAt", payment.getCreatedAt());

        SqlParameterSource params = new MapSqlParameterSource(m);
        KeyHolder keyHolder = new GeneratedKeyHolder();
        super.getNamedParameterJdbcTemplate().update(sql, params, keyHolder, new String[]{"id"});
        payment.setId(keyHolder.getKey().intValue());

        return payment;
    }

    @Override
    public Payment findById(int id) {
        String sql = "SELECT * FROM payment WHERE id = :id";
        SqlParameterSource params = new MapSqlParameterSource("id", id);
        return super.getNamedParameterJdbcTemplate().queryForObject(sql, params, new PaymentRowMapper());
    }

    @Override
    public List<Payment> findAll() {
        String sql = "SELECT * FROM payment";
        return super.getNamedParameterJdbcTemplate().query(sql, new PaymentRowMapper());
    }

    @Override
    public Payment findByOrderId(String orderId) {
        String sql = "SELECT * FROM payment WHERE orderId = :orderId";
        MapSqlParameterSource params = new MapSqlParameterSource("orderId", orderId);
        return super.getNamedParameterJdbcTemplate().queryForObject(sql, params, new PaymentRowMapper());
    }

    @Override
    public Payment findBySlotId(int slotId) {
        String sql = "SELECT * FROM payment WHERE slotId = :slotId";
        Map<String, Object> params = new HashMap<>();
        params.put("slotId", slotId);
        return super.getNamedParameterJdbcTemplate().queryForObject(sql, params, new PaymentRowMapper());
    }

    @Override
    public double totalRevenue() {
        String sql = "SELECT SUM(amount) FROM payment ";
        return getJdbcTemplate().queryForObject(sql, Double.class);
    }
}