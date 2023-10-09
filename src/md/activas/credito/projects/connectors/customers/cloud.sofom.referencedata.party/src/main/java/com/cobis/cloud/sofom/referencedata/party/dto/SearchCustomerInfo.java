package com.cobis.cloud.sofom.referencedata.party.dto;

import java.util.Date;

/**
 * Created by pclavijo on 20/06/2017.
 */
public class SearchCustomerInfo {
    private String buc;
    private String rfc;
    private String name;
    private String firstLastName;
    private String secondLastName;
    private Date dateOfBirth;

    public SearchCustomerInfo(String buc, String rfc, String name, String firstLastName, String secondLastName, Date dateOfBirth) {
        this.buc = buc;
        this.rfc = rfc;
        this.name = name;
        this.firstLastName = firstLastName;
        this.secondLastName = secondLastName;
        this.dateOfBirth = dateOfBirth;
    }

    public String getBuc() {
        return buc;
    }

    public void setBuc(String buc) {
        this.buc = buc;
    }

    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFirstLastName() {
        return firstLastName;
    }

    public void setFirstLastName(String firstLastName) {
        this.firstLastName = firstLastName;
    }

    public String getSecondLastName() {
        return secondLastName;
    }

    public void setSecondLastName(String secondLastName) {
        this.secondLastName = secondLastName;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    @Override
    public String toString() {
        return "SearchCustomerInfo{" +
                "buc='" + buc + '\'' +
                ", rfc='" + rfc + '\'' +
                ", name='" + name + '\'' +
                ", firstLastName='" + firstLastName + '\'' +
                ", secondLastName='" + secondLastName + '\'' +
                ", dateOfBirth=" + dateOfBirth +
                '}';
    }
}
