package com.cobiscorp.ecobis.cloud.service.dto.spouse;

import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;
import com.cobiscorp.ecobis.cloud.service.dto.prospect.Prospect;

public class SpouseAdditionalInfo {

    private int spouseId;
    private Integer countryOfBirth;
    private int nationality;
    private String education;
    private String profession;

    public int getSpouseId() {
        return spouseId;
    }

    public void setSpouseId(int spouseId) {
        this.spouseId = spouseId;
    }

    public Integer getCountryOfBirth() {
        return countryOfBirth;
    }

    public void setCountryOfBirth(Integer countryOfBirth) {
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

    public static SpouseAdditionalInfo fromResponse(CustomerResponse response) {
        if (response == null) {
            return null;
        }
        SpouseAdditionalInfo additional = new SpouseAdditionalInfo();
        additional.spouseId = response.getCustomerId();
        additional.countryOfBirth = response.getCountryCode();
        additional.nationality = response.getNationalityCodeAux();
        additional.education = response.getAcademicLevel();
        additional.profession = response.getProfession();
        return additional;
    }

    public CustomerTotalRequest toRequest(Prospect prospect) {
        CustomerTotalRequest request = prospect.toRequest();
        request.setCodePerson(spouseId);
        request.setCountryCode(countryOfBirth);
        request.setNationalityCodeAux(nationality);
        request.setLevelStudy(education);
        request.setProfession(profession);
        return request;
    }
}
