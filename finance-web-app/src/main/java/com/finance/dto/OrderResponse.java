package com.finance.dto;

public class OrderResponse {
    private String orderId;
    private long amountInPaise;
    private Double amountInRupees;
    private String currency;
    private String keyId;
    private String status;

    public OrderResponse() {}

    public OrderResponse(String orderId, long amountInPaise, Double amountInRupees, String currency, String keyId, String status) {
        this.orderId = orderId;
        this.amountInPaise = amountInPaise;
        this.amountInRupees = amountInRupees;
        this.currency = currency;
        this.keyId = keyId;
        this.status = status;
    }

    public String getOrderId() { return orderId; }
    public void setOrderId(String orderId) { this.orderId = orderId; }

    public long getAmountInPaise() { return amountInPaise; }
    public void setAmountInPaise(long amountInPaise) { this.amountInPaise = amountInPaise; }

    public Double getAmountInRupees() { return amountInRupees; }
    public void setAmountInRupees(Double amountInRupees) { this.amountInRupees = amountInRupees; }

    public String getCurrency() { return currency; }
    public void setCurrency(String currency) { this.currency = currency; }

    public String getKeyId() { return keyId; }
    public void setKeyId(String keyId) { this.keyId = keyId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
