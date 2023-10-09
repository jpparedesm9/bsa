package com.cobis.gestionasesores.data.models;

import com.cobis.gestionasesores.Constants;
import com.cobis.gestionasesores.data.models.responses.Message;

import java.io.Serializable;
import java.util.List;

/**
 * Created by mnaunay on 09/08/2017.
 */

public class SimulationResult implements Serializable {
    private boolean isSuccess;
    private double rate;
    private List<MonthlyPayment> monthlyPayments;
    private Message error;

    public SimulationResult(boolean isSuccess, double rate, List<MonthlyPayment> monthlyPayments, Message error) {
        this.isSuccess = isSuccess;
        this.monthlyPayments = monthlyPayments;
        this.rate = rate;
        this.error = error;
    }

    public boolean isSuccess() {
        return isSuccess;
    }

    public void setSuccess(boolean success) {
        isSuccess = success;
    }

    public List<MonthlyPayment> getMonthlyPayments() {
        return monthlyPayments;
    }

    public void setMonthlyPayments(List<MonthlyPayment> monthlyPayments) {
        this.monthlyPayments = monthlyPayments;
    }

    public double getRate() {
        return rate;
    }

    public void setRate(double rate) {
        this.rate = rate;
    }

    public Message getError() {
        return error;
    }

    public String getErrorMessage() {
        if (error != null) {
            if (isSuccess) {
                if (Constants.WARNING_SERVER_CODE.equals(error.getCode())) {
                    return error.getMessage();
                }
            } else {
                return error.getMessage();
            }
        }
        return null;
    }

    public void setError(Message error) {
        this.error = error;
    }
}
