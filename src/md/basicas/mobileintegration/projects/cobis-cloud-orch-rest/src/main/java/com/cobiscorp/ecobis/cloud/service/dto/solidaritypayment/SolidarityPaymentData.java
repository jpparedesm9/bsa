package com.cobiscorp.ecobis.cloud.service.dto.solidaritypayment;

import java.math.BigDecimal;

/**
 * Created by farid on 7/21/2017.
 */
public class SolidarityPaymentData {
    private Integer groupId;
    private String groupName;
    private Integer groupCycle;
    private String applicationDate;
    private String responsableOfficer;
    private String branchOffice;
    private String creditType;
    private BigDecimal groupAmount;
    private String rate;
    private String term;
    private BigDecimal liquidCollateralBalance;
    private Integer latePayments;
    private String nextDueDate;
    private BigDecimal amountChargeWholePayment;
    private Boolean debitsSavingAccounts;

    public SolidarityPaymentData() {
    }


    public Integer getGroupId() {
        return groupId;
    }

    public void setGroupId(Integer groupId) {
        this.groupId = groupId;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public Integer getGroupCycle() {
        return groupCycle;
    }

    public void setGroupCycle(Integer groupCycle) {
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

    public BigDecimal getGroupAmount() {
        return groupAmount;
    }

    public void setGroupAmount(BigDecimal groupAmount) {
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

    public BigDecimal getLiquidCollateralBalance() {
        return liquidCollateralBalance;
    }

    public void setLiquidCollateralBalance(BigDecimal liquidCollateralBalance) {
        this.liquidCollateralBalance = liquidCollateralBalance;
    }

    public Integer getLatePayments() {
        return latePayments;
    }

    public void setLatePayments(Integer latePayments) {
        this.latePayments = latePayments;
    }

    public String getNextDueDate() {
        return nextDueDate;
    }

    public void setNextDueDate(String nextDueDate) {
        this.nextDueDate = nextDueDate;
    }

    public BigDecimal getAmountChargeWholePayment() {
        return amountChargeWholePayment;
    }

    public void setAmountChargeWholePayment(BigDecimal amountChargeWholePayment) {
        this.amountChargeWholePayment = amountChargeWholePayment;
    }

    public Boolean getDebitsSavingAccounts() {
        return debitsSavingAccounts;
    }

    public void setDebitsSavingAccounts(Boolean debitsSavingAccounts) {
        this.debitsSavingAccounts = debitsSavingAccounts;
    }
}
