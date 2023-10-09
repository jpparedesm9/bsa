package com.cobis.cloud.sofom.operationsexecution.operationalservices.dto;

import java.util.Date;

/**
 * Created by pclavijo on 30/06/2017.
 */
public class SearchAccountForDisbursementInfo {
    private String rfc;
    private String name;
    private String firstLastName;
    private String secondLastName;
    private Date dateOfBirth;


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
        return "SearchAccountForDisbursementInfo{" +
                "rfc='" + rfc + '\'' +
                ", name='" + name + '\'' +
                ", firstLastName='" + firstLastName + '\'' +
                ", secondLastName='" + secondLastName + '\'' +
                ", dateOfBirth=" + dateOfBirth +
                '}';
    }
}
