package com.cobiscorp.ecobis.cloud.service.dto.creditapplication;

public class ApplicationData {

    private int processInstance;
    private String applicationType;
    private String creditDestination;
    private String rate;
    private String term;
    private String frecuency;
    private boolean promotion;
    private double amountOriginalRequest;
    private double authorizedAmount;
    private String displacement;


    public String getApplicationType() {
        return applicationType;
    }

    public void setApplicationType(String applicationType) {
        this.applicationType = applicationType;
    }

    public String getCreditDestination() {
        return creditDestination;
    }

    public void setCreditDestination(String creditDestination) {
        this.creditDestination = creditDestination;
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

    public String getFrecuency() {
        return frecuency;
    }

    public void setFrecuency(String frecuency) {
        this.frecuency = frecuency;
    }

    public boolean isPromotion() {
        return promotion;
    }

    public void setPromotion(boolean promotion) {
        this.promotion = promotion;
    }

    public double getAmountOriginalRequest() {
        return amountOriginalRequest;
    }

    public void setAmountOriginalRequest(double amountOriginalRequest) {
        this.amountOriginalRequest = amountOriginalRequest;
    }

    public double getAuthorizedAmount() {
        return authorizedAmount;
    }

    public void setAuthorizedAmount(double authorizedAmount) {
        this.authorizedAmount = authorizedAmount;
    }

    public int getProcessInstance() {
        return processInstance;
    }

    public void setProcessInstance(int processInstance) {
        this.processInstance = processInstance;
    }
    
    public String getDisplacement() {
		return displacement;
	}

	public void setDisplacement(String displacement) {
		this.displacement = displacement;
	}
}
