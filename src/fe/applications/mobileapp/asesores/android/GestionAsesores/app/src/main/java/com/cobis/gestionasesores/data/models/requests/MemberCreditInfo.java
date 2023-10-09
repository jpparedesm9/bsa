package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by mnaunay on 08/08/2017.
 */

public class MemberCreditInfo {
    private String role;
    private int cycleNumber;
    private int code;
    private String name;
    private boolean participant;
    private double amountRequestedOriginal;
    private double authorizedAmount;
    private double liquidGuarantee;
    private double voluntarySavings;
    private double proposedMaximumAmount;
    private String riskLevel;
    private String rfc;

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public int getCycleNumber() {
        return cycleNumber;
    }

    public void setCycleNumber(int cycleNumber) {
        this.cycleNumber = cycleNumber;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean getParticipant() {
        return participant;
    }

    public void setParticipant(boolean participant) {
        this.participant = participant;
    }

    public double getAmountRequestedOriginal() {
        return amountRequestedOriginal;
    }

    public void setAmountRequestedOriginal(double amountRequestedOriginal) {
        this.amountRequestedOriginal = amountRequestedOriginal;
    }

    public double getAuthorizedAmount() {
        return authorizedAmount;
    }

    public void setAuthorizedAmount(double authorizedAmount) {
        this.authorizedAmount = authorizedAmount;
    }

    public double getLiquidGuarantee() {
        return liquidGuarantee;
    }

    public void setLiquidGuarantee(double liquidGuarantee) {
        this.liquidGuarantee = liquidGuarantee;
    }

    public double getVoluntarySavings() {
        return voluntarySavings;
    }

    public void setVoluntarySavings(double voluntarySavings) {
        this.voluntarySavings = voluntarySavings;
    }

    public double getProposedMaximumAmount() {
        return proposedMaximumAmount;
    }

    public void setProposedMaximumAmount(double proposedMaximumAmount) {
        this.proposedMaximumAmount = proposedMaximumAmount;
    }

    public String getRiskLevel() {
        return riskLevel;
    }

    public void setRiskLevel(String riskLevel) {
        this.riskLevel = riskLevel;
    }

    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }
}
