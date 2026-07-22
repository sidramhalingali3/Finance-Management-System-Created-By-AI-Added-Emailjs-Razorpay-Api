package com.finance.controller;

import com.finance.dao.UserDao;
import com.finance.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class AuthController {

    @Autowired
    private UserDao userDao;

    @GetMapping("/")
    public String index() {
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String showLogin(HttpSession session) {
        if (session.getAttribute("username") != null) {
            String role = (String) session.getAttribute("role");
            if ("Admin".equals(role)) return "redirect:/admin";
            if ("Customer".equals(role)) return "redirect:/customer";
            if ("Collector".equals(role)) return "redirect:/collector";
        }
        return "login";
    }

    @PostMapping("/login")
    public ModelAndView loginUser(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            HttpServletRequest request) {
            
        ModelAndView mv = new ModelAndView();
        User user = userDao.validateUser(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());

            if ("Admin".equals(user.getRole())) {
                mv.setViewName("redirect:/admin");
            } else if ("Customer".equals(user.getRole())) {
                mv.setViewName("redirect:/customer");
            } else if ("Collector".equals(user.getRole())) {
                mv.setViewName("redirect:/collector");
            } else {
                mv.setViewName("login");
                mv.addObject("error", "Invalid role");
            }
        } else {
            mv.setViewName("login");
            mv.addObject("error", "Invalid username or password");
        }
        return mv;
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
