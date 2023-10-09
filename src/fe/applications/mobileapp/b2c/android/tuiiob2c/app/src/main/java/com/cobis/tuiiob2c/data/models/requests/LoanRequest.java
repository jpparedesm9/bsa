package com.cobis.tuiiob2c.data.models.requests;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class LoanRequest {

    @SerializedName("amount")
    @Expose
    private double amount;

    /**
     * No args constructor for use in serialization
     *
     */
    public LoanRequest() {
    }

    /**
     *
     * @param amount
     */
    public LoanRequest(double amount) {
        super();
        this.amount = amount;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }
}