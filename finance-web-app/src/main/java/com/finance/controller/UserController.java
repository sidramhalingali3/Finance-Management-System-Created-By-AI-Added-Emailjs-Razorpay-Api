package com.finance.controller;

import com.finance.dao.FinanceDao;
import com.finance.dao.LoanDao;
import com.finance.dao.UserDao;
import com.finance.model.Finance;
import com.finance.model.Loan;
import com.finance.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class UserController {

    @Autowired
    private UserDao userDao;
    
    @Autowired
    private FinanceDao financeDao;
    
    @Autowired
    private LoanDao loanDao;

    @GetMapping("/admin")
    public ModelAndView adminPage(HttpSession session) {
        if (!"Admin".equals(session.getAttribute("role"))) return new ModelAndView("redirect:/login");

        ModelAndView mv = new ModelAndView("admin");
        
        List<Loan> allLoans = loanDao.findAll();
        double totalLoans = allLoans.stream()
                .filter(l -> l.getLoanAmount() != null)
                .mapToDouble(Loan::getLoanAmount).sum();
        
        List<Finance> allFinance = financeDao.findAll();
        double totalCollected = allFinance.stream()
                .filter(f -> ("Approved".equals(f.getStatus()) || f.getStatus() == null) && f.getAmount() != null)
                .mapToDouble(Finance::getAmount)
                .sum();
        
        mv.addObject("totalLoans", totalLoans);
        mv.addObject("totalCollected", totalCollected);
        mv.addObject("financeList", allFinance);
        return mv;
    }

    @GetMapping("/customer")
    public ModelAndView customerPage(HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"Customer".equals(role)) return new ModelAndView("redirect:/login");

        String username = (String) session.getAttribute("username");
        ModelAndView mv = new ModelAndView("customer");
        
        List<Loan> userLoans = loanDao.findByUsername(username);
        List<Finance> userFinances = financeDao.findByUsername(username);
        
        mv.addObject("loanList", userLoans);
        mv.addObject("financeList", userFinances);
        return mv;
    }

    @GetMapping("/phonepePayment")
    public String showPhonePePayment(HttpSession session) {
        if (!"Customer".equals(session.getAttribute("role"))) return "redirect:/login";
        return "phonepe_payment";
    }

    @GetMapping("/razorpayPayment")
    public String showRazorpayPayment(HttpSession session) {
        if (!"Customer".equals(session.getAttribute("role"))) return "redirect:/login";
        return "razorpay_payment";
    }

    @GetMapping("/collector")
    public ModelAndView collectorPage(HttpSession session) {
        if (!"Collector".equals(session.getAttribute("role"))) return new ModelAndView("redirect:/login");

        ModelAndView mv = new ModelAndView("collector");
        List<User> customers = userDao.findAll().stream()
                .filter(u -> "Customer".equals(u.getRole()))
                .collect(Collectors.toList());
                
        List<Finance> allFinances = financeDao.findAll();
        
        mv.addObject("customers", customers);
        mv.addObject("financeList", allFinances);
        return mv;
    }

    @GetMapping("/users")
    public ModelAndView listUsers(HttpSession session) {
        if (!"Admin".equals(session.getAttribute("role"))) return new ModelAndView("redirect:/login");
        List<User> users = userDao.findAll();
        ModelAndView mv = new ModelAndView("users");
        mv.addObject("users", users);
        return mv;
    }

    @GetMapping("/addUser")
    public String showAddUser(HttpSession session) {
        if (!"Admin".equals(session.getAttribute("role"))) return "redirect:/login";
        return "addUser";
    }

    @PostMapping("/addUser")
    public String addUser(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            @RequestParam("role") String role,
            HttpSession session) {
            
        if (!"Admin".equals(session.getAttribute("role"))) return "redirect:/login";

        if (username != null && !username.trim().isEmpty() && password != null && !password.trim().isEmpty()) {
            User user = new User(username.trim(), password, role);
            userDao.save(user);
            return "redirect:/admin?userSuccess=true";
        }
        return "redirect:/admin?userError=empty_fields";
    }

    @GetMapping("/deleteUser")
    public String deleteUser(@RequestParam("id") Integer id, HttpSession session) {
        if (!"Admin".equals(session.getAttribute("role"))) return "redirect:/login";
        userDao.delete(id);
        return "redirect:/users?deleteSuccess=true";
    }
}
