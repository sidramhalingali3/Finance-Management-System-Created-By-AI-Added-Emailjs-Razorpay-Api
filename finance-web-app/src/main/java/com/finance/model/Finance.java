package com.finance.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "finance")
public class Finance {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String username;
    private String type;
    private Double amount;
    private String description;
    
    @Temporal(TemporalType.DATE)
    private Date date;
    
    private String collector = "Self/Unknown";
    private String status = "Approved";
    
    @Column(name = "current_paid_amount")
    private Double currentPaidAmount = 0.0;
    
    @Column(name = "current_remaining_amount")
    private Double currentRemainingAmount = 0.0;

    public Finance() {}

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    
    public Double getAmount() { return amount; }
    public void setAmount(Double amount) { this.amount = amount; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }
    
    public String getCollector() { return collector; }
    public void setCollector(String collector) { this.collector = collector; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public Double getCurrentPaidAmount() { return currentPaidAmount; }
    public void setCurrentPaidAmount(Double currentPaidAmount) { this.currentPaidAmount = currentPaidAmount; }
    
    public Double getCurrentRemainingAmount() { return currentRemainingAmount; }
    public void setCurrentRemainingAmount(Double currentRemainingAmount) { this.currentRemainingAmount = currentRemainingAmount; }
}
