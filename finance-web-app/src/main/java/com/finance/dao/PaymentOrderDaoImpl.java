package com.finance.dao;

import com.finance.model.PaymentOrder;
import com.finance.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PaymentOrderDaoImpl implements PaymentOrderDao {

    private Session getSession() {
        return HibernateUtil.getSessionFactory().openSession();
    }

    @Override
    public void save(PaymentOrder paymentOrder) {
        Session session = getSession();
        Transaction tx = session.beginTransaction();
        session.save(paymentOrder);
        tx.commit();
        session.close();
    }

    @Override
    public void update(PaymentOrder paymentOrder) {
        Session session = getSession();
        Transaction tx = session.beginTransaction();
        session.update(paymentOrder);
        tx.commit();
        session.close();
    }

    @Override
    public PaymentOrder findByOrderId(String orderId) {
        Session session = getSession();
        Query<PaymentOrder> query = session.createQuery("from PaymentOrder where orderId = :orderId", PaymentOrder.class);
        query.setParameter("orderId", orderId);
        List<PaymentOrder> list = query.list();
        session.close();
        return (list != null && !list.isEmpty()) ? list.get(0) : null;
    }

    @Override
    public List<PaymentOrder> findByCustomerUsername(String username) {
        Session session = getSession();
        Query<PaymentOrder> query = session.createQuery("from PaymentOrder where customerUsername = :username order by createdAt desc", PaymentOrder.class);
        query.setParameter("username", username);
        List<PaymentOrder> list = query.list();
        session.close();
        return list;
    }

    @Override
    public List<PaymentOrder> findAll() {
        Session session = getSession();
        List<PaymentOrder> list = session.createQuery("from PaymentOrder order by id desc", PaymentOrder.class).list();
        session.close();
        return list;
    }
}
