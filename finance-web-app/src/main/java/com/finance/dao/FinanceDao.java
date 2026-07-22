package com.finance.dao;

import com.finance.model.Finance;
import java.util.List;

public interface FinanceDao {
    void save(Finance finance);
    void update(Finance finance);
    void delete(Integer id);
    Finance findById(Integer id);
    List<Finance> findAll();
    List<Finance> findByUsername(String username);
    List<Finance> findByStatus(String status);
}
