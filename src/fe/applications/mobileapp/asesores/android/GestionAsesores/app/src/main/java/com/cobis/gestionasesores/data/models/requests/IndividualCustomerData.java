package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by jescudero on 17/08/2017.
 */

public class IndividualCustomerData {
    private int code;
    private String name;
    private String rfc;
    private int cycle;
    private String applicationDate;
    private boolean partner;
    private boolean agreeRenew;
    private double lastAmountApplication;
    private String riskLevel;
    private int avalCode;
    private String avalRfc;
    private String avalName;
    private String avalRiskLevel;

    private IndividualCustomerData(Builder builder){
        this.code = builder.code;
        this.name = builder.name;
        this.rfc = builder.rfc;
        this.cycle = builder.cycle;
        this.applicationDate = builder.applicationDate;
        this.partner = builder.partner;
        this.agreeRenew = builder.agreeRenew;
        this.lastAmountApplication = builder.lastAmountApplication;
        this.riskLevel = builder.riskLevel;
        this.avalCode = builder.avalCode;
        this.avalRfc = builder.avalRfc;
        this.avalName = builder.avalName;
        this.avalRiskLevel = builder.avalRiskLevel;
    }

    public int getCode() {
        return code;
    }

    public String getName() {
        return name;
    }

    public String getRfc() {
        return rfc;
    }

    public int getCycle() {
        return cycle;
    }

    public String getApplicationDate() {
        return applicationDate;
    }

    public boolean isPartner() {
        return partner;
    }

    public boolean isAgreeRenew() {
        return agreeRenew;
    }

    public double getLastAmountApplication() {
        return lastAmountApplication;
    }

    public String getRiskLevel() {
        return riskLevel;
    }

    public int getAvalCode() {
        return avalCode;
    }

    public String getAvalRfc() {
        return avalRfc;
    }

    public String getAvalName() {
        return avalName;
    }

    public String getAvalRiskLevel() {
        return avalRiskLevel;
    }

    public static class Builder {
        private int code;
        private String name;
        private String rfc;
        private int cycle;
        private String applicationDate;
        private boolean partner;
        private boolean agreeRenew;
        private double lastAmountApplication;
        private String riskLevel;
        private int avalCode;
        private String avalRfc;
        private String avalName;
        private String avalRiskLevel;

        public Builder setCode(int code) {
            this.code = code;
            return this;
        }

        public Builder setName(String name) {
            this.name = name;
            return this;
        }

        public Builder setRfc(String rfc) {
            this.rfc = rfc;
            return this;
        }

        public Builder setCycle(int cycle) {
            this.cycle = cycle;
            return this;
        }

        public Builder setApplicationDate(String applicationDate) {
            this.applicationDate = applicationDate;
            return this;
        }

        public Builder setPartner(boolean partner) {
            this.partner = partner;
            return this;
        }

        public Builder setAgreeRenew(boolean agreeRenew) {
            this.agreeRenew = agreeRenew;
            return this;
        }

        public Builder setLastAmountApplication(double lastAmountApplication) {
            this.lastAmountApplication = lastAmountApplication;
            return this;
        }

        public Builder setRiskLevel(String riskLevel) {
            this.riskLevel = riskLevel;
            return this;
        }

        public Builder setAvalCode(int avalCode) {
            this.avalCode = avalCode;
            return this;
        }

        public Builder setAvalRfc(String avalRfc) {
            this.avalRfc = avalRfc;
            return this;
        }

        public Builder setAvalName(String avalName) {
            this.avalName = avalName;
            return this;
        }

        public Builder setAvalRiskLevel(String avalRiskLevel) {
            this.avalRiskLevel = avalRiskLevel;
            return this;
        }

        public IndividualCustomerData build(){
            return new IndividualCustomerData(this);
        }
    }
}
