package com.cobis.gestionasesores.data.models;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by JosueOrtiz on 03/08/2017.
 * Its the model of one Payment. in a amoritzation table
 */

public class MonthlyPayment implements Serializable {

    private int period;
    private double balance;
    private double amortization;
    private double interes;
    private double interesIva;
    private double payment;
    private Date date;

    public MonthlyPayment(int period, double balance, double amortization, double interes, double interestIva, double payment, Date date) {
        this.period = period;
        this.balance = balance;
        this.amortization = amortization;
        this.interes = interes;
        this.interesIva = interestIva;
        this.payment = payment;
        this.date = date;
    }

    public MonthlyPayment() {
    }

    public int getPeriod() {
        return period;
    }

    public double getPayment() {
        return payment;
    }

    public double getInteres() {
        return interes;
    }

    public double getInteresIva() {return interesIva;}

    public double getAmortization() {
        return amortization;
    }

    public double getBalance() {
        return balance;
    }

    public Date getDate() {return date;}

    public void setPeriod(int period) {
        this.period = period;
    }

    public void setInteres(double interes) {
        this.interes = interes;
    }

    public void setInteresIva(double interesIva) {this.interesIva = interesIva;}

    public void setPayment(double payment) {this.payment = payment;}

    public void setAmortization(double amortization) {
        this.amortization = amortization;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public void setDate(Date date) {this.date = date;}
}
