package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by jescudero on 17/08/2017.
 */

public class IndividualApplicationData {
    private int processInstance;
    private String applicationType;
    private String creditDestination;
    private String rate;
    private String term;
    private String frecuency;
    private boolean promotion;
    private double amountOriginalRequest;
    private double authorizedAmount;

    public IndividualApplicationData(){
        super();
    }
    private IndividualApplicationData(Builder builder){
        this.applicationType = builder.applicationType;
        this.creditDestination = builder.creditDestination;
        this.rate = builder.rate;
        this.term = builder.term;
        this.frecuency = builder.frecuency;
        this.promotion = builder.promotion;
        this.amountOriginalRequest = builder.amountOriginalRequest;
        this.authorizedAmount = builder.authorizedAmount;
        this.processInstance = builder.processInstance;
    }

    public int getProcessInstance() {
        return processInstance;
    }

    public String getApplicationType() {
        return applicationType;
    }

    public String getCreditDestination() {
        return creditDestination;
    }

    public String getRate() {
        return rate;
    }

    public String getTerm() {
        return term;
    }

    public String getFrecuency() {
        return frecuency;
    }

    public boolean isPromotion() {
        return promotion;
    }

    public double getAmountOriginalRequest() {
        return amountOriginalRequest;
    }

    public double getAuthorizedAmount() {
        return authorizedAmount;
    }

    public static class Builder {
        private int processInstance;
        private String applicationType;
        private String creditDestination;
        private String rate;
        private String term;
        private String frecuency;
        private boolean promotion;
        private double amountOriginalRequest;
        private double authorizedAmount;

        public Builder setProcessInstance(int processInstance) {
            this.processInstance = processInstance;
            return this;
        }

        public Builder setApplicationType(String applicationType) {
            this.applicationType = applicationType;
            return this;
        }

        public Builder setCreditDestination(String creditDestination) {
            this.creditDestination = creditDestination;
            return this;
        }

        public Builder setRate(String rate) {
            this.rate = rate;
            return this;
        }

        public Builder setTerm(String term) {
            this.term = term;
            return this;
        }

        public Builder setFrecuency(String frecuency) {
            this.frecuency = frecuency;
            return this;
        }

        public Builder setPromotion(boolean promotion) {
            this.promotion = promotion;
            return this;
        }

        public Builder setAmountOriginalRequest(double amountOriginalRequest) {
            this.amountOriginalRequest = amountOriginalRequest;
            return this;
        }

        public Builder setAuthorizedAmount(double authorizedAmount) {
            this.authorizedAmount = authorizedAmount;
            return this;
        }

        public IndividualApplicationData build() {
            return new IndividualApplicationData(this);
        }
    }
}
