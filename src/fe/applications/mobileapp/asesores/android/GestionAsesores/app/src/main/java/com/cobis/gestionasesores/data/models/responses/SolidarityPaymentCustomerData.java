/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cobis.gestionasesores.data.models.responses;

/**
 * @author mnaunay
 */
public class SolidarityPaymentCustomerData {
    private int customerId;
    private String customerName;
    private double amountPayWholePayment;
    private double dueBalance;

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public double getAmountPayWholePayment() {
        return amountPayWholePayment;
    }

    public void setAmountPayWholePayment(double amountPayWholePayment) {
        this.amountPayWholePayment = amountPayWholePayment;
    }

    public double getDueBalance() {
        return dueBalance;
    }

    public void setDueBalance(double dueBalance) {
        this.dueBalance = dueBalance;
    }
}
