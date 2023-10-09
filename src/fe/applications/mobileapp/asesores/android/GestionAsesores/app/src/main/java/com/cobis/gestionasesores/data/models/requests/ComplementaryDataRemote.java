package com.cobis.gestionasesores.data.models.requests;

public class ComplementaryDataRemote {
    private String passport;
    private String phoneMessage;
    private String ifeNumber;
    private String serialNumberSignatureElect;
    private String personMessage;
    private Boolean buroAntecedent;
    private String landlineOne;

    public String getPassport() {
        return passport;
    }

    public void setPassport(String passport) {
        this.passport = passport;
    }

    public String getPhoneMessage() {
        return phoneMessage;
    }

    public void setPhoneMessage(String phoneMessage) {
        this.phoneMessage = phoneMessage;
    }

    public String getIfeNumber() {
        return ifeNumber;
    }

    public void setIfeNumber(String ifeNumber) {
        this.ifeNumber = ifeNumber;
    }

    public String getSerialNumberSignatureElect() {
        return serialNumberSignatureElect;
    }

    public void setSerialNumberSignatureElect(String serialNumberSignatureElect) {
        this.serialNumberSignatureElect = serialNumberSignatureElect;
    }

    public String getPersonMessage() {
        return personMessage;
    }

    public void setPersonMessage(String personMessage) {
        this.personMessage = personMessage;
    }

    public Boolean getBuroAntecedent() {
        return buroAntecedent;
    }

    public void setBuroAntecedent(Boolean buroAntecedent) {
        this.buroAntecedent = buroAntecedent;
    }

    public String getLandlineOne() {
        return landlineOne;
    }

    public void setLandlineOne(String landlineOne) {
        this.landlineOne = landlineOne;
    }
}
