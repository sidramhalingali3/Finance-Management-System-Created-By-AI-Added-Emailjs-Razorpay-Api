package com.finance.dao;

import com.finance.model.Loan;
import java.util.List;

public interface LoanDao {
    void save(Loan loan);
    void update(Loan loan);
    void delete(Integer id);
    Loan findById(Integer id);
    List<Loan> findAll();
    List<Loan> findByUsername(String username);
}
