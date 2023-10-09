package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by bqtdesa02 on 7/28/2017.
 */

public class PartnerInfo {
    private int customerId;
    private int spouseId;
    private String firstName;
    private String secondName;
    private String surname;
    private String secondSurname;
    private String birthDate;
    private String gender;
    private int cityBirth;
    private String rfc;

    public int getSpouseId() {
        return spouseId;
    }

    public void setSpouseId(int spouseId) {
        this.spouseId = spouseId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getSecondName() {
        return secondName;
    }

    public void setSecondName(String secondName) {
        this.secondName = secondName;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getSecondSurname() {
        return secondSurname;
    }

    public void setSecondSurname(String secondSurname) {
        this.secondSurname = secondSurname;
    }

    public String getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public int getCityBirth() {
        return cityBirth;
    }

    public void setCityBirth(int cityBirth) {
        this.cityBirth = cityBirth;
    }

    public String getRfc() {
        return rfc;
    }


    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }
}
