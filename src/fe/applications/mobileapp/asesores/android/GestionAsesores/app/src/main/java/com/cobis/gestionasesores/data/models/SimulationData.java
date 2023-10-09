package com.cobis.gestionasesores.data.models;

import java.io.Serializable;

/**
 * Created by User on 09/08/2017.
 */

public class SimulationData implements Serializable{

    private String name;
    private double amount;
    private String term;
    private Long date;
    private double interest;
    private String frequency;
    private String creditType;
    private boolean tryOnline;

    public SimulationData(String name, double amount, String term, long date, double interest, String frequency, String creditType) {
        this.name = name;
        this.amount = amount;
        this.term = term;
        this.date = date;
        this.interest = interest;
        this.frequency = frequency;
        this.creditType = creditType;
    }
    public SimulationData() {

    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }

    public Long getDate() {
        return date;
    }

    public void setDate(Long date) {
        this.date = date;
    }

    public double getInterest() {
        return interest;
    }

    public void setInterest(double interest) {
        this.interest = interest;
    }

    public String getFrequency() {
        return frequency;
    }

    public void setFrequency(String frequency) {
        this.frequency = frequency;
    }

    public String getCreditType() {
        return creditType;
    }

    public void setCreditType(String creditType) {
        this.creditType = creditType;
    }

    public boolean isTryOnline() {
        return tryOnline;
    }

    public void setTryOnline(boolean tryOnline) {
        this.tryOnline = tryOnline;
    }
}
