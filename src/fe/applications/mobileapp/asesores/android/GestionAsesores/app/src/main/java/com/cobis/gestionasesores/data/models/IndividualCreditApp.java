package com.cobis.gestionasesores.data.models;

import com.cobis.gestionasesores.data.enums.CreditAppType;

/**
 * Represent an individual credit application request
 * Created by mnaunay on 22/06/2017.
 */

public class IndividualCreditApp extends CreditApp {
    private int customerServerId;
    private String customerNumber;
    private String rfc;
    private int cycle;
    private String adviser;
    private String branchOffice;
    private boolean isPartner;
    private boolean renovation;
    private double previousCreditAmount;
    private String destination;
    private String rate;
    private String term;
    private String frequency;
    private boolean isPromotion;
    private double authorizedAmount;
    private String riskLevel;

    private Guarantor guarantor;

    /**
     * Default constructor is used for JSON parse
     */
    IndividualCreditApp() {
       super(CreditAppType.INDIVIDUAL);
    }

    private IndividualCreditApp(Builder builder) {
        super(builder);
        customerServerId = builder.customerServerId;
        customerNumber = builder.customerNumber;
        rfc = builder.rfc;
        cycle = builder.cycle;
        adviser = builder.adviser;
        branchOffice = builder.branchOffice;
        isPartner = builder.isPartner;
        renovation = builder.renovation;
        previousCreditAmount = builder.previousCreditAmount;
        destination = builder.destination;
        rate = builder.rate;
        term = builder.term;
        frequency = builder.frequency;
        isPromotion = builder.isPromotion;
        authorizedAmount = builder.authorizedAmount;
        riskLevel = builder.riskLevel;
        guarantor = builder.guarantor;
        action = builder.serverAction;
    }


    public String getCustomerNumber() {
        return customerNumber;
    }

    public String getRfc() {
        return rfc;
    }

    public int getCycle() {
        return cycle;
    }

    public String getAdviser() {
        return adviser;
    }

    public String getBranchOffice() {
        return branchOffice;
    }

    public boolean isPartner() {
        return isPartner;
    }

    public boolean isRenovation() {
        return renovation;
    }

    public double getPreviousCreditAmount() {
        return previousCreditAmount;
    }

    public String getDestination() {
        return destination;
    }

    public String getRate() {
        return rate;
    }

    public String getTerm() {
        return term;
    }

    public String getFrequency() {
        return frequency;
    }

    public boolean isPromotion() {
        return isPromotion;
    }

    public double getAuthorizedAmount() {
        return authorizedAmount;
    }

    public String getRiskLevel() {
        return riskLevel;
    }

    public Guarantor getGuarantor() {
        return guarantor;
    }

    public int getCustomerServerId() {
        return customerServerId;
    }

    public Builder buildUpon(){
        return new Builder(this);
    }

    public static class Builder extends InternalBuilder<Builder>{

        private ServerAction serverAction;
        private int customerServerId;
        private String customerNumber;
        private String rfc;
        private int cycle;
        private String adviser;
        private String branchOffice;
        private boolean isPartner;
        private boolean renovation;
        private double previousCreditAmount;
        private String destination;
        private String rate;
        private String term;
        private String frequency;
        private boolean isPromotion;
        private double authorizedAmount;
        private String riskLevel;
        private Guarantor guarantor;

        private Builder(IndividualCreditApp individualCreditApp){
            super(individualCreditApp);
            customerNumber = individualCreditApp.customerNumber;
            rfc = individualCreditApp.rfc;
            cycle = individualCreditApp.cycle;
            adviser = individualCreditApp.adviser;
            branchOffice = individualCreditApp.branchOffice;
            isPartner = individualCreditApp.isPartner;
            renovation = individualCreditApp.renovation;
            previousCreditAmount = individualCreditApp.previousCreditAmount;
            destination = individualCreditApp.destination;
            rate = individualCreditApp.rate;
            term = individualCreditApp.term;
            frequency = individualCreditApp.frequency;
            isPromotion = individualCreditApp.isPromotion;
            authorizedAmount = individualCreditApp.authorizedAmount;
            riskLevel = individualCreditApp.riskLevel;
            guarantor = individualCreditApp.guarantor;
            customerServerId = individualCreditApp.customerServerId;
            serverAction = individualCreditApp.action;
        }

        public Builder(){
            super(CreditAppType.INDIVIDUAL);
            renovation = true;
        }


        public Builder setCustomerNumber(String customerNumber) {
            this.customerNumber = customerNumber;
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

        public Builder setAdviser(String adviser) {
            this.adviser = adviser;
            return this;
        }

        public Builder setBranchOffice(String branchOffice) {
            this.branchOffice = branchOffice;
            return this;
        }

        public Builder setPartner(boolean partner) {
            isPartner = partner;
            return this;
        }

        public Builder setRenovation(boolean renovation) {
            this.renovation = renovation;
            return this;
        }

        public Builder setPreviousCreditAmount(double previousCreditAmount) {
            this.previousCreditAmount = previousCreditAmount;
            return this;
        }

        public Builder setDestination(String destination) {
            this.destination = destination;
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

        public Builder setFrequency(String frequency) {
            this.frequency = frequency;
            return this;
        }

        public Builder setPromotion(boolean promotion) {
            isPromotion = promotion;
            return this;
        }

        public Builder setAuthorizedAmount(double authorizedAmount) {
            this.authorizedAmount = authorizedAmount;
            return this;
        }

        public Builder setRiskLevel(String riskLevel) {
            this.riskLevel = riskLevel;
            return this;
        }

        public Builder setGuarantor(Guarantor guarantor) {
            this.guarantor = guarantor;
            return this;
        }
        public Builder setCustomerServerId(int customerServerId) {
            this.customerServerId = customerServerId;
            return this;
        }

        public IndividualCreditApp build(){
            return new IndividualCreditApp(this);
        }
    }
}
