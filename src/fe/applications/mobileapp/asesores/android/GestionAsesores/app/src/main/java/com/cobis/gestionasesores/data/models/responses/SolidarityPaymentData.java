package com.cobis.gestionasesores.data.models.responses;

public class SolidarityPaymentData {
    private int groupId;
    private String groupName;
    private int groupCycle;
    private String applicationDate;
    private String responsableOfficer;
    private String branchOffice;
    private String creditType;
    private double groupAmount;
    private String rate;
    private String term;
    private double liquidCollateralBalance;
    private int latePayments;
    private String nextDueDate;
    private double amountChargeWholePayment;
    private boolean debitsSavingAccounts;

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public int getGroupCycle() {
        return groupCycle;
    }

    public void setGroupCycle(int groupCycle) {
        this.groupCycle = groupCycle;
    }

    public String getApplicationDate() {
        return applicationDate;
    }

    public void setApplicationDate(String applicationDate) {
        this.applicationDate = applicationDate;
    }

    public String getResponsableOfficer() {
        return responsableOfficer;
    }

    public void setResponsableOfficer(String responsableOfficer) {
        this.responsableOfficer = responsableOfficer;
    }

    public String getBranchOffice() {
        return branchOffice;
    }

    public void setBranchOffice(String branchOffice) {
        this.branchOffice = branchOffice;
    }

    public String getCreditType() {
        return creditType;
    }

    public void setCreditType(String creditType) {
        this.creditType = creditType;
    }

    public double getGroupAmount() {
        return groupAmount;
    }

    public void setGroupAmount(double groupAmount) {
        this.groupAmount = groupAmount;
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

    public double getLiquidCollateralBalance() {
        return liquidCollateralBalance;
    }

    public void setLiquidCollateralBalance(double liquidCollateralBalance) {
        this.liquidCollateralBalance = liquidCollateralBalance;
    }

    public int getLatePayments() {
        return latePayments;
    }

    public void setLatePayments(int latePayments) {
        this.latePayments = latePayments;
    }

    public String getNextDueDate() {
        return nextDueDate;
    }

    public void setNextDueDate(String nextDueDate) {
        this.nextDueDate = nextDueDate;
    }

    public double getAmountChargeWholePayment() {
        return amountChargeWholePayment;
    }

    public void setAmountChargeWholePayment(double amountChargeWholePayment) {
        this.amountChargeWholePayment = amountChargeWholePayment;
    }

    public boolean isDebitsSavingAccounts() {
        return debitsSavingAccounts;
    }

    public void setDebitsSavingAccounts(boolean debitsSavingAccounts) {
        this.debitsSavingAccounts = debitsSavingAccounts;
    }
}
