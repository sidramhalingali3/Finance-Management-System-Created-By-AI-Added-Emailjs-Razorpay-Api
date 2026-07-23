package com.finance.dao;

import com.finance.model.PaymentOrder;
import java.util.List;

public interface PaymentOrderDao {
    void save(PaymentOrder paymentOrder);
    void update(PaymentOrder paymentOrder);
    PaymentOrder findByOrderId(String orderId);
    List<PaymentOrder> findByCustomerUsername(String username);
    List<PaymentOrder> findAll();
}
