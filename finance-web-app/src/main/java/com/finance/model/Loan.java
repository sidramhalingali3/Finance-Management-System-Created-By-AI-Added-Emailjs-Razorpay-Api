package com.finance.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "loans")
public class Loan {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String username;
    
    @Column(name = "loan_amount")
    private Double loanAmount;
    
    @Column(name = "paid_amount")
    private Double paidAmount = 0.0;
    
    @Column(name = "remaining_amount")
    private Double remainingAmount = 0.0;
    
    @Temporal(TemporalType.DATE)
    private Date date;

    public Loan() {}

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public Double getLoanAmount() { return loanAmount; }
    public void setLoanAmount(Double loanAmount) { this.loanAmount = loanAmount; }
    
    public Double getPaidAmount() { return paidAmount; }
    public void setPaidAmount(Double paidAmount) { this.paidAmount = paidAmount; }
    
    public Double getRemainingAmount() { return remainingAmount; }
    public void setRemainingAmount(Double remainingAmount) { this.remainingAmount = remainingAmount; }
    
    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }
}
