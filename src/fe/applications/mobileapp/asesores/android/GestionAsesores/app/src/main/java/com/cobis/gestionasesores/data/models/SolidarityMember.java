package com.cobis.gestionasesores.data.models;

import android.support.annotation.VisibleForTesting;

import java.io.Serializable;

/**
 * Created by bqtdesa02 on 8/21/2017.
 */

public class SolidarityMember implements Serializable{

    private int id;
    private String name;
    private double paymentAmount;
    private double owedAmount;

    public SolidarityMember() {
    }

    @VisibleForTesting
    public SolidarityMember(double paymentAmount) {
        this.paymentAmount = paymentAmount;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPaymentAmount() {
        return paymentAmount;
    }

    public void setPaymentAmount(double paymentAmount) {
        this.paymentAmount = paymentAmount;
    }

    public double getOwedAmount() {
        return owedAmount;
    }

    public void setOwedAmount(double owedAmount) {
        this.owedAmount = owedAmount;
    }
}
