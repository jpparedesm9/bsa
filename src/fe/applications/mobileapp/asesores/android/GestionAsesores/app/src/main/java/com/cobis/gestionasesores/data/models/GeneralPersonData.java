package com.cobis.gestionasesores.data.models;

import com.bayteq.libcore.util.StringUtils;

import java.io.Serializable;

/**
 * Created by bqtdesa02 on 6/13/2017.
 */

public class GeneralPersonData implements Serializable{
    private String firstName;
    private String secondName;
    private String lastName;
    private String secondLastName;
    private String sex;
    private Long birthDate;
    private String birthCountry;
    private String birthEntityCode;
    private String birthEntityAdditionalCode;
    private String nationality;
    private String educationLevel;
    private String occupation;
    private String rfc;

    private GeneralPersonData(Builder builder) {
        firstName = builder.firstName;
        secondName = builder.secondName;
        lastName = builder.lastName;
        secondLastName = builder.secondLastName;
        sex = builder.sex;
        birthDate = builder.birthDate;
        birthCountry = builder.birthCountry;
        birthEntityCode = builder.birthEntityCode;
        birthEntityAdditionalCode = builder.birthEntityAdditionalCode;
        nationality = builder.nationality;
        educationLevel = builder.educationLevel;
        occupation = builder.occupation;
        rfc = builder.rfc;
    }

    public GeneralPersonData merge(GeneralPersonData input) {
        if(StringUtils.isNotEmpty(input.firstName)){
            this.firstName = input.firstName;
        }
        if(StringUtils.isNotEmpty(input.secondName)){
            this.secondName = input.secondName;
        }

        if(StringUtils.isNotEmpty(input.lastName)){
            this.lastName = input.lastName;
        }

        if(StringUtils.isNotEmpty(input.secondLastName)){
            this.secondLastName = input.secondLastName;
        }
        if(StringUtils.isNotEmpty(input.sex)){
            this.sex = input.sex;
        }
        if(input.birthDate != null){
            this.birthDate = input.birthDate;

        }
        if(StringUtils.isNotEmpty(input.birthCountry)){
            this.birthCountry = input.birthCountry;
        }
        if(StringUtils.isNotEmpty(input.birthEntityCode)){
            this.birthEntityCode = input.birthEntityCode;
        }
        if(StringUtils.isNotEmpty(input.birthEntityAdditionalCode)){
            this.birthEntityAdditionalCode = input.birthEntityAdditionalCode;
        }
        if(StringUtils.isNotEmpty(input.nationality)){
            this.nationality = input.nationality;
        }
        if(StringUtils.isNotEmpty(input.educationLevel)){
            this.educationLevel = input.educationLevel;
        }
        if(StringUtils.isNotEmpty(input.occupation)){
            this.occupation = input.occupation;
        }
        if(StringUtils.isNotEmpty(input.rfc)){
            this.rfc = input.rfc;
        }
        return this;
    }


    public String getName() {
        if (firstName == null && secondName == null) return null;
        String name = "";

        if (!StringUtils.isEmpty(firstName)) {
            name += firstName;
        }

        if (!StringUtils.isEmpty(secondName)) {
            name += " " + secondName;
        }

        return name.trim();
    }

    public String getFullName(){
        return (getName()+" "+lastName).trim();
    }

    public String getFirstName() {
        return firstName;
    }

    public String getSecondName() {
        return secondName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getSecondLastName() {
        return secondLastName;
    }

    public String getSex() {
        return sex;
    }

    public Long getBirthDate() {
        return birthDate;
    }

    public String getBirthCountry() {
        return birthCountry;
    }

    public String getBirthEntityCode() {
        return birthEntityCode;
    }

    public String getBirthEntityAdditionalCode() {
        return birthEntityAdditionalCode;
    }

    public String getNationality() {
        return nationality;
    }

    public String getEducationLevel() {
        return educationLevel;
    }

    public String getOccupation() {
        return occupation;
    }

    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    public void setBirthDate(Long birthDate) {
        this.birthDate = birthDate;
    }

    public void setBirthCountry(String birthCountry) {
        this.birthCountry = birthCountry;
    }

    public static class Builder{
        private String firstName;
        private String secondName;
        private String lastName;
        private String secondLastName;
        private String sex;
        private Long birthDate;
        private String birthCountry;
        private String birthEntityCode;
        private String birthEntityAdditionalCode;
        private String nationality;
        private String educationLevel;
        private String occupation;
        private String rfc;

        public Builder setFirstName(String firstName) {
            this.firstName = firstName;
            return this;
        }

        public Builder setSecondName(String secondName) {
            this.secondName = secondName;
            return this;
        }

        public Builder setLastName(String lastName) {
            this.lastName = lastName;
            return this;
        }

        public Builder setSecondLastName(String secondLastName) {
            this.secondLastName = secondLastName;
            return this;
        }

        public Builder setSex(String sex) {
            this.sex = sex;
            return this;
        }

        public Builder setBirthDate(Long birthDate) {
            this.birthDate = birthDate;
            return this;
        }

        public Builder setBirthCountry(String birthCountry) {
            this.birthCountry = birthCountry;
            return this;
        }

        public Builder setBirthEntityCode(String birthEntityCode) {
            this.birthEntityCode = birthEntityCode;
            return this;
        }

        public Builder setBirthEntityAdditionalCode(String birthEntityAdditionalCode) {
            this.birthEntityAdditionalCode = birthEntityAdditionalCode;
            return this;
        }

        public Builder setNationality(String nationality) {
            this.nationality = nationality;
            return this;
        }

        public Builder setEducationLevel(String educationLevel) {
            this.educationLevel = educationLevel;
            return this;
        }

        public Builder setOccupation(String occupation) {
            this.occupation = occupation;
            return this;
        }

        public Builder setRfc(String rfc) {
            this.rfc = rfc;
            return this;
        }

        public GeneralPersonData build(){
            return new GeneralPersonData(this);
        }
    }
}
