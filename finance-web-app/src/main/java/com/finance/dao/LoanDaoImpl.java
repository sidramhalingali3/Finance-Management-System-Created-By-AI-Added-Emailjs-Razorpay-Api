package com.finance.dao;

import com.finance.model.Loan;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class LoanDaoImpl implements LoanDao {

    Configuration conf = new Configuration().configure().addAnnotatedClass(Loan.class);
    SessionFactory sf = conf.buildSessionFactory();

    @Override
    public void save(Loan loan) {
        Session session = sf.openSession();
        Transaction tx = session.beginTransaction();
        session.save(loan);
        tx.commit();
        session.close();
    }

    @Override
    public void update(Loan loan) {
        Session session = sf.openSession();
        Transaction tx = session.beginTransaction();
        session.update(loan);
        tx.commit();
        session.close();
    }

    @Override
    public void delete(Integer id) {
        Session session = sf.openSession();
        Transaction tx = session.beginTransaction();
        Loan loan = session.get(Loan.class, id);
        if (loan != null) {
            session.delete(loan);
        }
        tx.commit();
        session.close();
    }

    @Override
    public Loan findById(Integer id) {
        Session session = sf.openSession();
        Loan loan = session.get(Loan.class, id);
        session.close();
        return loan;
    }

    @Override
    public List<Loan> findAll() {
        Session session = sf.openSession();
        List<Loan> list = session.createQuery("from Loan order by id desc", Loan.class).list();
        session.close();
        return list;
    }

    @Override
    public List<Loan> findByUsername(String username) {
        Session session = sf.openSession();
        Query<Loan> query = session.createQuery("from Loan where username=:username order by id desc", Loan.class);
        query.setParameter("username", username);
        List<Loan> list = query.list();
        session.close();
        return list;
    }
}
