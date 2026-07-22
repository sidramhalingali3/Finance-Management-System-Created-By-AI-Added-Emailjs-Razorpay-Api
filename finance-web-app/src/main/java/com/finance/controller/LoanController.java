package com.finance.controller;

import com.finance.dao.LoanDao;
import com.finance.model.Loan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class LoanController {

    @Autowired
    private LoanDao loanDao;

    @GetMapping("/addLoan")
    public String showAddLoan(HttpSession session) {
        if (!"Admin".equals(session.getAttribute("role"))) return "redirect:/login";
        return "addLoan";
    }

    @PostMapping("/addLoan")
    public String addLoan(
            @RequestParam("username") String username,
            @RequestParam("amount") Double amount,
            HttpSession session) {

        if (!"Admin".equals(session.getAttribute("role"))) return "redirect:/login";

        try {
            Loan loan = new Loan();
            loan.setUsername(username);
            loan.setLoanAmount(amount);
            loan.setRemainingAmount(amount);
            loan.setPaidAmount(0.0);
            loan.setDate(new java.sql.Date(System.currentTimeMillis()));
            
            loanDao.save(loan);
            return "redirect:/loans?success=true";
        } catch (Exception e) {
            return "redirect:/addLoan?loanError=insert_failed";
        }
    }

    @GetMapping("/loans")
    public ModelAndView listLoans(HttpSession session) {
        if (!"Admin".equals(session.getAttribute("role"))) return new ModelAndView("redirect:/login");
        List<Loan> loans = loanDao.findAll();
        ModelAndView mv = new ModelAndView("loans");
        mv.addObject("loans", loans);
        return mv;
    }
}
