package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by mnaunay on 27/07/2017.
 */

public class PersonalInformationCustomer extends PersonalInformation {

    private String bankCode;
    private String bankAccount;
    private int countryOfBirth;
    private int nationality;
    private String education;
    private String profession;
    private int numberOfDependents;
    private String rfc;
    private boolean hasOtherIncome;
    private String otherIncomeSource;
    private double otherIncome;
    private int numberOfCycles;
    private boolean personPep;
    private String pepRelationship;
    private String riskBureau;

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

    public int getNumberOfDependents() {
        return numberOfDependents;
    }

    public void setNumberOfDependents(int numberOfDependents) {
        this.numberOfDependents = numberOfDependents;
    }

    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    public boolean hasOtherIncome() {
        return hasOtherIncome;
    }

    public void setHasOtherIncome(boolean hasOtherIncome) {
        this.hasOtherIncome = hasOtherIncome;
    }

    public String getOtherIncomeSource() {
        return otherIncomeSource;
    }

    public void setOtherIncomeSource(String otherIncomeSource) {
        this.otherIncomeSource = otherIncomeSource;
    }

    public double getOtherIncome() {
        return otherIncome;
    }

    public void setOtherIncome(double otherIncome) {
        this.otherIncome = otherIncome;
    }

    public int getNumberOfCycles() {
        return numberOfCycles;
    }

    public void setNumberOfCycles(int numberOfCycles) {
        this.numberOfCycles = numberOfCycles;
    }

    public boolean isPersonPep() {
        return personPep;
    }

    public void setPersonPep(boolean personPep) {
        this.personPep = personPep;
    }

    public String getPepRelationship() {
        return pepRelationship;
    }

    public void setPepRelationship(String pepRelationship) {
        this.pepRelationship = pepRelationship;
    }

    public String getBankCode() {
        return bankCode;
    }

    public void setBankCode(String bankCode) {
        this.bankCode = bankCode;
    }

    public String getBankAccount() {
        return bankAccount;
    }

    public void setBankAccount(String bankAccount) {
        this.bankAccount = bankAccount;
    }

    public String getRiskBureau() {
        return riskBureau;
    }

    public void setRiskBureau(String riskBureau) {
        this.riskBureau = riskBureau;
    }
}
