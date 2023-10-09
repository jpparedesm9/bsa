package com.cobis.gestionasesores.data.models;

import java.io.Serializable;

/**
 * Created by mnaunay on 26/06/2017.
 */

public class MemberCreditApp implements Serializable {

    private int customerServerId;
    private String rfc;
    private String customerName;
    private String position;
    private int cycleInGroup;
    private String customerNumber;
    private boolean isPartOfCycle;
    private double requestAmount;
    private double authorizedAmount;
    private double maxProposedAmount;
    private String riskLevel;
    private boolean isRenovation;

    private MemberCreditApp(Builder builder) {
        rfc = builder.rfc;
        customerName = builder.customerName;
        position = builder.position;
        cycleInGroup = builder.cycleInGroup;
        customerNumber = builder.customerNumber;
        isPartOfCycle = builder.isPartOfCycle;
        requestAmount = builder.requestAmount;
        authorizedAmount = builder.authorizedAmount;
        maxProposedAmount = builder.maxProposedAmount;
        riskLevel = builder.riskLevel;
        isRenovation = builder.isRenovation;
        customerServerId = builder.customerServerId;
    }

    public int getCustomerServerId() {
        return customerServerId;
    }

    public String getRfc() {
        return rfc;
    }

    public String getPosition() {
        return position;
    }

    public int getCycleInGroup() {
        return cycleInGroup;
    }

    public String getCustomerNumber() {
        return customerNumber;
    }

    public boolean isPartOfCycle() {
        return isPartOfCycle;
    }

    public double getRequestAmount() {
        return requestAmount;
    }

    public double getAuthorizedAmount() {
        return authorizedAmount;
    }

    public double getMaxProposedAmount() {
        return maxProposedAmount;
    }

    public String getRiskLevel() {
        return riskLevel;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setRequestAmount(double requestAmount) {
        this.requestAmount = requestAmount;
    }

    public void setAuthorizedAmount(double authorizedAmount) {
        this.authorizedAmount = authorizedAmount;
    }

    public void setCustomerNumber(String customerNumber) {
        this.customerNumber = customerNumber;
    }

    public boolean isRenovation() {
        return isRenovation;
    }

    public void setPartOfCycle(boolean partOfCycle) {
        isPartOfCycle = partOfCycle;
    }

    public void setRenovation(boolean renovation) {
        isRenovation = renovation;
    }

    public static class Builder{

        private String rfc;
        private String customerName;
        private String position;
        private int cycleInGroup;
        private String customerNumber;
        private boolean isPartOfCycle;
        private double requestAmount;
        private double authorizedAmount;
        private double maxProposedAmount;
        private String riskLevel;
        private boolean isRenovation;
        private int customerServerId;

        public Builder(){
            isPartOfCycle = true;
        }

        public Builder setRfc(String rfc) {
            this.rfc = rfc;
            return this;
        }

        public Builder setPosition(String position) {
            this.position = position;
            return this;
        }

        public Builder setCycleInGroup(int cycleInGroup) {
            this.cycleInGroup = cycleInGroup;
            return this;
        }

        public Builder setCustomerNumber(String customerNumber) {
            this.customerNumber = customerNumber;
            return this;
        }

        public Builder setPartOfCycle(boolean partOfCycle) {
            isPartOfCycle = partOfCycle;
            return this;
        }

        public Builder setRequestAmount(double requestAmount) {
            this.requestAmount = requestAmount;
            return this;
        }

        public Builder setAuthorizedAmount(double authorizedAmount) {
            this.authorizedAmount = authorizedAmount;
            return this;
        }

        public Builder setMaxProposedAmount(double maxProposedAmount) {
            this.maxProposedAmount = maxProposedAmount;
            return this;
        }

        public Builder setRiskLevel(String riskLevel) {
            this.riskLevel = riskLevel;
            return this;
        }

        public Builder setCustomerName(String customerName) {
            this.customerName = customerName;
            return this;
        }

        public Builder setRenovation(boolean renovation) {
            isRenovation = renovation;
            return this;
        }

        public Builder setCustomerServerId(int customerServerId) {
            this.customerServerId = customerServerId;
            return this;
        }

        public MemberCreditApp build(){
            return new MemberCreditApp(this);
        }
    }
}
