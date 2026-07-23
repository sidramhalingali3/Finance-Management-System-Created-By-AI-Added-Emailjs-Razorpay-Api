package com.finance.dao;

import com.finance.model.User;
import com.finance.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserDaoImpl implements UserDao {

    private Session getSession() {
        return HibernateUtil.getSessionFactory().openSession();
    }

    @Override
    public void save(User user) {
        Session session = getSession();
        Transaction tx = session.beginTransaction();
        session.save(user);
        tx.commit();
        session.close();
    }

    @Override
    public User findByUsername(String username) {
        Session session = getSession();
        Query<User> query = session.createQuery("from User where username=:username", User.class);
        query.setParameter("username", username);
        User user = query.uniqueResult();
        session.close();
        return user;
    }

    @Override
    public List<User> findAll() {
        Session session = getSession();
        List<User> list = session.createQuery("from User order by id desc", User.class).list();
        session.close();
        return list;
    }

    @Override
    public void delete(Integer id) {
        Session session = getSession();
        Transaction tx = session.beginTransaction();
        User user = session.get(User.class, id);
        if (user != null) {
            session.delete(user);
        }
        tx.commit();
        session.close();
    }

    @Override
    public User validateUser(String username, String password) {
        Session session = getSession();
        Query<User> query = session.createQuery("from User where username=:username and password=:password", User.class);
        query.setParameter("username", username);
        query.setParameter("password", password);
        User user = query.uniqueResult();
        session.close();
        return user;
    }
}
