package com.cobis.gestionasesores.data.models;

import com.cobis.gestionasesores.data.enums.TaskType;

import java.util.List;

/**
 * Created by bqtdesa02 on 8/15/2017.
 */

public class SolidarityPayment extends Task {

    private int cycle;
    private Long date;
    private double creditAmount;
    private String rate;
    private String term;
    private double guaranteeBalance;
    private int overduePayments;
    private Long nextDueDate;
    private double paymentDue;
    private boolean debitAccount;
    private List<SolidarityMember> mMembers;

    public SolidarityPayment() {
        super(TaskType.SOLIDARITY_PAYMENT);
        debitAccount = true;
    }

    public int getCycle() {
        return cycle;
    }

    public void setCycle(int cycle) {
        this.cycle = cycle;
    }

    public Long getDate() {
        return date;
    }

    public void setDate(Long date) {
        this.date = date;
    }

    public double getCreditAmount() {
        return creditAmount;
    }

    public void setCreditAmount(double creditAmount) {
        this.creditAmount = creditAmount;
    }

    public String getRate() {
        return rate;
    }

    public void setRate(String rate) {
        this.rate = rate;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }

    public double getGuaranteeBalance() {
        return guaranteeBalance;
    }

    public void setGuaranteeBalance(double guaranteeBalance) {
        this.guaranteeBalance = guaranteeBalance;
    }

    public int getOverduePayments() {
        return overduePayments;
    }

    public void setOverduePayments(int overduePayments) {
        this.overduePayments = overduePayments;
    }

    public Long getNextDueDate() {
        return nextDueDate;
    }

    public void setNextDueDate(Long nextDueDate) {
        this.nextDueDate = nextDueDate;
    }

    public double getPaymentDue() {
        return paymentDue;
    }

    public void setPaymentDue(double paymentDue) {
        this.paymentDue = paymentDue;
    }

    public boolean isDebitAccount() {
        return debitAccount;
    }

    public void setDebitAccount(boolean debitAccount) {
        this.debitAccount = debitAccount;
    }

    public List<SolidarityMember> getMembers() {
        return mMembers;
    }

    public void setMembers(List<SolidarityMember> members) {
        mMembers = members;
    }
}
