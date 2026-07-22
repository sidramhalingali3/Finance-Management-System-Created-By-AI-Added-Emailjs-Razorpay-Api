package com.finance.dao;

import com.finance.model.Finance;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FinanceDaoImpl implements FinanceDao {

    Configuration conf = new Configuration().configure().addAnnotatedClass(Finance.class);
    SessionFactory sf = conf.buildSessionFactory();

    @Override
    public void save(Finance finance) {
        Session session = sf.openSession();
        Transaction tx = session.beginTransaction();
        session.save(finance);
        tx.commit();
        session.close();
    }

    @Override
    public void update(Finance finance) {
        Session session = sf.openSession();
        Transaction tx = session.beginTransaction();
        session.update(finance);
        tx.commit();
        session.close();
    }

    @Override
    public void delete(Integer id) {
        Session session = sf.openSession();
        Transaction tx = session.beginTransaction();
        Finance finance = session.get(Finance.class, id);
        if (finance != null) {
            session.delete(finance);
        }
        tx.commit();
        session.close();
    }

    @Override
    public Finance findById(Integer id) {
        Session session = sf.openSession();
        Finance finance = session.get(Finance.class, id);
        session.close();
        return finance;
    }

    @Override
    public List<Finance> findAll() {
        Session session = sf.openSession();
        List<Finance> list = session.createQuery("from Finance", Finance.class).list();
        session.close();
        return list;
    }

    @Override
    public List<Finance> findByUsername(String username) {
        Session session = sf.openSession();
        Query<Finance> query = session.createQuery("from Finance where username=:username", Finance.class);
        query.setParameter("username", username);
        List<Finance> list = query.list();
        session.close();
        return list;
    }

    @Override
    public List<Finance> findByStatus(String status) {
        Session session = sf.openSession();
        Query<Finance> query = session.createQuery("from Finance where status=:status", Finance.class);
        query.setParameter("status", status);
        List<Finance> list = query.list();
        session.close();
        return list;
    }
}
