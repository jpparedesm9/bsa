package com.cobiscorp.mobile.model.fingerid;

public class FingerRequestNode {
    private String channel;
    private String branch;
    private String transactionType;
    private String transactionId;
    private PersonalINEData personalINEData;
    private Ubiety ubiety;
    private Minutiae minutiae;
    private String agree;

    public String getChannel() {
        return channel;
    }
    public void setChannel(String channel) {
        this.channel = channel;
    }

    public String getBranch() {
        return branch;
    }
    public void setBranch(String branch) {
        this.branch = branch;
    }

    public String getTransactionType() {
        return transactionType;
    }
    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public String getTransactionId() {
        return transactionId;
    }
    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public PersonalINEData getPersonalINEData() {
        return personalINEData;
    }
    public void setPersonalINEData(PersonalINEData personalINEData) {
        this.personalINEData = personalINEData;
    }

    public Ubiety getUbiety() {
        return ubiety;
    }
    public void setUbiety(Ubiety ubiety) {
        this.ubiety = ubiety;
    }

    public Minutiae getMinutiae() {
        return minutiae;
    }
    public void setMinutiae(Minutiae minutiae) {
        this.minutiae = minutiae;
    }

    public String getAgree() {
        return agree;
    }
    public void setAgree(String agree) {
        this.agree = agree;
    }

}
