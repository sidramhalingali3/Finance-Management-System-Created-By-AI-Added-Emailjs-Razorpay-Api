package com.finance.util;

import com.finance.model.Finance;
import com.finance.model.Loan;
import com.finance.model.PaymentOrder;
import com.finance.model.User;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {
    private static SessionFactory sessionFactory;

    public static synchronized SessionFactory getSessionFactory() {
        if (sessionFactory == null || sessionFactory.isClosed()) {
            try {
                Configuration conf = new Configuration().configure()
                        .addAnnotatedClass(User.class)
                        .addAnnotatedClass(Finance.class)
                        .addAnnotatedClass(Loan.class)
                        .addAnnotatedClass(PaymentOrder.class);

                String dbUrl = System.getenv("DB_URL");
                String dbUser = System.getenv("DB_USER");
                String dbPass = System.getenv("DB_PASS");

                if (dbUrl != null && !dbUrl.trim().isEmpty()) {
                    conf.setProperty("hibernate.connection.url", dbUrl);
                }
                if (dbUser != null && !dbUser.trim().isEmpty()) {
                    conf.setProperty("hibernate.connection.username", dbUser);
                }
                if (dbPass != null && !dbPass.trim().isEmpty()) {
                    conf.setProperty("hibernate.connection.password", dbPass);
                }

                sessionFactory = conf.buildSessionFactory();
            } catch (Throwable ex) {
                System.err.println("Initial SessionFactory creation failed: " + ex);
                throw new ExceptionInInitializerError(ex);
            }
        }
        return sessionFactory;
    }
}
