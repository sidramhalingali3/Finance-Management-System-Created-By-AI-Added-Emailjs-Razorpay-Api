package com.finance.dao;

import com.finance.model.Loan;
import com.finance.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class LoanDaoImpl implements LoanDao {

    private Session getSession() {
        return HibernateUtil.getSessionFactory().openSession();
    }

    @Override
    public void save(Loan loan) {
        Session session = getSession();
        Transaction tx = session.beginTransaction();
        session.save(loan);
        tx.commit();
        session.close();
    }

    @Override
    public void update(Loan loan) {
        Session session = getSession();
        Transaction tx = session.beginTransaction();
        session.update(loan);
        tx.commit();
        session.close();
    }

    @Override
    public void delete(Integer id) {
        Session session = getSession();
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
        Session session = getSession();
        Loan loan = session.get(Loan.class, id);
        session.close();
        return loan;
    }

    @Override
    public List<Loan> findAll() {
        Session session = getSession();
        List<Loan> list = session.createQuery("from Loan order by id desc", Loan.class).list();
        session.close();
        return list;
    }

    @Override
    public List<Loan> findByUsername(String username) {
        Session session = getSession();
        Query<Loan> query = session.createQuery("from Loan where username=:username order by id desc", Loan.class);
        query.setParameter("username", username);
        List<Loan> list = query.list();
        session.close();
        return list;
    }
}
