package com.cobiscorp.ecobis.cloud.service.dto.simulation;

import cobiscorp.ecobis.assets.cloud.dto.LoanSimulatorResponse;
import com.cobiscorp.ecobis.cloud.service.util.CalendarUtil;

public class AmortizationEntry {

    private int dividend;
    private String date;
    private double balance;
    private double capital;
    private double interest;
    private double iva;
    private double others;
    private double total;

    public static AmortizationEntry fromResponse(LoanSimulatorResponse response) {
        AmortizationEntry entry = new AmortizationEntry();
        entry.setDividend(response.getDividend());
        if (response.getDate() != null) {
            entry.setDate(CalendarUtil.toISOTime(response.getDate()));
        }
        entry.setBalance(response.getBalance());
        entry.setCapital(response.getCapital());
        entry.setInterest(response.getInterest());
        entry.setIva(response.getIva());
        entry.setOthers(response.getOthers());
        entry.setTotal(response.getTotal());
        return entry;
    }

    public int getDividend() {
        return dividend;
    }

    public void setDividend(int dividend) {
        this.dividend = dividend;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public double getCapital() {
        return capital;
    }

    public void setCapital(double capital) {
        this.capital = capital;
    }

    public double getInterest() {
        return interest;
    }

    public void setInterest(double interest) {
        this.interest = interest;
    }

    public double getIva() {
        return iva;
    }

    public void setIva(double iva) {
        this.iva = iva;
    }

    public double getOthers() {
        return others;
    }

    public void setOthers(double others) {
        this.others = others;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }
}
