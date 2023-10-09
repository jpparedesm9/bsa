package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by bqtdesa02 on 7/28/2017.
 */

public class PaymentCapacityInfo {

    private double monthlyIncome;
    private double monthlyBusinessExpenses;
    private double monthlyFamilyExpense;

    public double getMonthlyIncome() {
        return monthlyIncome;
    }

    public void setMonthlyIncome(double monthlyIncome) {
        this.monthlyIncome = monthlyIncome;
    }

    public double getMonthlyBusinessExpenses() {
        return monthlyBusinessExpenses;
    }

    public void setMonthlyBusinessExpenses(double monthlyBusinessExpenses) {
        this.monthlyBusinessExpenses = monthlyBusinessExpenses;
    }

    public double getMonthlyFamilyExpense() {
        return monthlyFamilyExpense;
    }

    public void setMonthlyFamilyExpense(double monthlyFamilyExpense) {
        this.monthlyFamilyExpense = monthlyFamilyExpense;
    }
}
