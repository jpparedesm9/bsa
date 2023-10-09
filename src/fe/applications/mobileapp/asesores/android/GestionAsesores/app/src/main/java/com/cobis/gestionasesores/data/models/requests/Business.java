package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by bqtdesa02 on 7/28/2017.
 */

public class Business {
    private int businessId;
    private String name;
    private String transfer;
    private String openDate;
    private String phone;
    private int phoneId;
    private String industry;
    private int yearsInBusiness;
    private String withWhatResourceWillPayForCredit;
    private double monthlyRevenue;
    private String creditPurpose;
    private int yearsAtAddress;
    private String ownershipType;

    public String getOwnershipType() {
        return ownershipType;
    }

    public void setOwnershipType(String ownershipType) {
        this.ownershipType = ownershipType;
    }

    public int getYearsAtAddress() {
        return yearsAtAddress;
    }

    public void setYearsAtAddress(int yearsAtAddress) {
        this.yearsAtAddress = yearsAtAddress;
    }

    public int getBusinessId() {
        return businessId;
    }

    public void setBusinessId(int businessId) {
        this.businessId = businessId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTransfer() {
        return transfer;
    }

    public void setTransfer(String transfer) {
        this.transfer = transfer;
    }

    public String getOpenDate() {
        return openDate;
    }

    public void setOpenDate(String openDate) {
        this.openDate = openDate;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getPhoneId() {
        return phoneId;
    }

    public void setPhoneId(int phoneId) {
        this.phoneId = phoneId;
    }

    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }

    public int getYearsInBusiness() {
        return yearsInBusiness;
    }

    public void setYearsInBusiness(int yearsInBusiness) {
        this.yearsInBusiness = yearsInBusiness;
    }

    public String getWithWhatResourceWillPayForCredit() {
        return withWhatResourceWillPayForCredit;
    }

    public void setWithWhatResourceWillPayForCredit(String withWhatResourceWillPayForCredit) {
        this.withWhatResourceWillPayForCredit = withWhatResourceWillPayForCredit;
    }

    public double getMonthlyRevenue() {
        return monthlyRevenue;
    }

    public void setMonthlyRevenue(double monthlyRevenue) {
        this.monthlyRevenue = monthlyRevenue;
    }

    public String getCreditPurpose() {
        return creditPurpose;
    }

    public void setCreditPurpose(String creditPurpose) {
        this.creditPurpose = creditPurpose;
    }
}
