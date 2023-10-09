package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by bqtdesa02 on 7/28/2017.
 */

public class PartnerAdditionalInfo {

    private int spouseId;
    private int countryOfBirth;
    private int nationality;
    private String education;
    private String profession;

    public int getSpouseId() {
        return spouseId;
    }

    public void setSpouseId(int spouseId) {
        this.spouseId = spouseId;
    }

    public int getCountryOfBirth() {
        return countryOfBirth;
    }

    public void setCountryOfBirth(int countryOfBirth) {
        this.countryOfBirth = countryOfBirth;
    }

    public int getNationality() {
        return nationality;
    }

    public void setNationality(int nationality) {
        this.nationality = nationality;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getProfession() {
        return profession;
    }

    public void setProfession(String profession) {
        this.profession = profession;
    }
}
