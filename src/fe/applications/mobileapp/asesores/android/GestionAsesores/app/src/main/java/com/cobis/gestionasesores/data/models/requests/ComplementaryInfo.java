package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by bqtdesa02 on 7/28/2017.
 */

public class ComplementaryInfo {

    private String passport;
    private int codePerson;
    private String phoneMessage;
    private String ifeNumber;
    private String serialNumberSignatureElect;
    private String personMessage;
    private String buroAntecedent;

    public String getPassport() {
        return passport;
    }

    public void setPassport(String passport) {
        this.passport = passport;
    }

    public int getCodePerson() {
        return codePerson;
    }

    public void setCodePerson(int codePerson) {
        this.codePerson = codePerson;
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

    public String getBuroAntecedent() {
        return buroAntecedent;
    }

    public void setBuroAntecedent(String buroAntecedent) {
        this.buroAntecedent = buroAntecedent;
    }
}
