package com.cobiscorp.ecobis.cloud.service.dto.creditapplication;

public class CustomerData {

    private int code;
    private String name;
    private String rfc;
    private int cycle;
    private String applicationDate;
    private int officer;
    private int office;
    boolean partner;
    boolean agreeRenew;
    double lastAmountApplication;
    String riskLevel;
    private int avalCode;
    private String avalRfc;
    private String avalName;
    private String avalRiskLevel;


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

    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    public int getCycle() {
        return cycle;
    }

    public void setCycle(int cycle) {
        this.cycle = cycle;
    }

    public String getApplicationDate() {
        return applicationDate;
    }

    public void setApplicationDate(String applicationDate) {
        this.applicationDate = applicationDate;
    }

    public int getOfficer() {
        return officer;
    }

    public void setOfficer(int officer) {
        this.officer = officer;
    }

    public int getOffice() {
        return office;
    }

    public void setOffice(int office) {
        this.office = office;
    }

    public boolean isPartner() {
        return partner;
    }

    public void setPartner(boolean partner) {
        this.partner = partner;
    }

    public boolean isAgreeRenew() {
        return agreeRenew;
    }

    public void setAgreeRenew(boolean agreeRenew) {
        this.agreeRenew = agreeRenew;
    }

    public double getLastAmountApplication() {
        return lastAmountApplication;
    }

    public void setLastAmountApplication(double lastAmountApplication) {
        this.lastAmountApplication = lastAmountApplication;
    }

    public String getRiskLevel() {
        return riskLevel;
    }

    public void setRiskLevel(String riskLevel) {
        this.riskLevel = riskLevel;
    }

    public int getAvalCode() {
        return avalCode;
    }

    public void setAvalCode(int avalCode) {
        this.avalCode = avalCode;
    }

    public String getAvalRfc() {
        return avalRfc;
    }

    public void setAvalRfc(String avalRfc) {
        this.avalRfc = avalRfc;
    }

    public String getAvalName() {
        return avalName;
    }

    public void setAvalName(String avalName) {
        this.avalName = avalName;
    }

    public String getAvalRiskLevel() {
        return avalRiskLevel;
    }

    public void setAvalRiskLevel(String avalRiskLevel) {
        this.avalRiskLevel = avalRiskLevel;
    }
}
