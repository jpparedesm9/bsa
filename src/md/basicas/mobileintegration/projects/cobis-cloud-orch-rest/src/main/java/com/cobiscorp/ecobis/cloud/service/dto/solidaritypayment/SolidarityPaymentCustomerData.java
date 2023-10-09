package com.cobiscorp.ecobis.cloud.service.dto.solidaritypayment;

import java.math.BigDecimal;

/**
 * Created by farid on 7/21/2017.
 */
public class SolidarityPaymentCustomerData {
    private Integer customerId;
    private String customerName;
    private BigDecimal amountPayWholePayment;
    private BigDecimal dueBalance;

    public SolidarityPaymentCustomerData() {
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public BigDecimal getAmountPayWholePayment() {
        return amountPayWholePayment;
    }

    public void setAmountPayWholePayment(BigDecimal amountPayWholePayment) {
        this.amountPayWholePayment = amountPayWholePayment;
    }

    public BigDecimal getDueBalance() {
        return dueBalance;
    }

    public void setDueBalance(BigDecimal dueBalance) {
        this.dueBalance = dueBalance;
    }
}
