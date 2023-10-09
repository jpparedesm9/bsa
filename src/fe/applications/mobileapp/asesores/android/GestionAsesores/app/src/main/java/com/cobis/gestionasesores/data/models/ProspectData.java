package com.cobis.gestionasesores.data.models;

import com.bayteq.libcore.util.StringUtils;

/**
 * Created by bqtdesa02 on 6/28/2017.
 */

public class ProspectData extends SectionData<ProspectData> {
    private String firstName;
    private String secondName;
    private String lastName;
    private String secondLastName;
    private String birthEntityCode;
    private String birthEntityAdditionalCode;
    private Long birthDate;
    private String email;
    private String sex;
    private String civilStatus;
    private String rfc;
    private String curp;
    private AddressData addressData;
    private String number;
    private String accountNumber;
    private int emailAddressId;

    private ProspectData(Builder builder) {
        firstName = builder.firstName;
        secondName = builder.secondName;
        birthEntityCode = builder.birthEntityCode;
        birthEntityAdditionalCode = builder.birthEntityAdditionalCode;
        lastName = builder.lastName;
        secondLastName = builder.secondLastName;
        birthDate = builder.birthDate;
        email = builder.email;
        sex = builder.sex;
        civilStatus = builder.civilStatus;
        rfc = builder.rfc;
        curp = builder.curp;
        addressData = builder.addressData;
        number = builder.number;
        accountNumber = builder.accountNumber;
        emailAddressId = builder.emailAddressId;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getSecondName() {
        return secondName;
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
        return (getName()+ " " + lastName + " " + (StringUtils.isNotEmpty(secondLastName)?secondLastName:"")).trim();
    }

    public String getBirthEntityCode() {
        return birthEntityCode;
    }

    public String getBirthEntityAdditionalCode() {
        return birthEntityAdditionalCode;
    }

    public String getLastName() {
        return lastName;
    }

    public String getSecondLastName() {
        return secondLastName;
    }

    public Long getBirthDate() {
        return birthDate;
    }

    public String getEmail() {
        return email;
    }

    public String getSex() {
        return sex;
    }

    public String getCivilStatus() {
        return civilStatus;
    }

    public String getRfc() {
        return rfc;
    }

    public String getCurp() {
        return curp;
    }

    public AddressData getAddressData() {
        return addressData;
    }

    public String getNumber() {
        return number;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    public void setCurp(String curp) {
        this.curp = curp;
    }

    public void setBirthDate(Long birthDate) {
        this.birthDate = birthDate;
    }

    public void setAddressData(AddressData addressData) {
        this.addressData = addressData;
    }

    //these setters are made to refill de data from the server.

    public void setNumber(String number) {
        this.number = number;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public void setCivilStatus(String civilStatus) {
        this.civilStatus = civilStatus;
    }

    public void setEmailAddressId(int emailAddressId) {
        this.emailAddressId = emailAddressId;
    }

    public int getEmailAddressId() {
        return emailAddressId;
    }

    @Override
    public ProspectData merge(ProspectData data) {
        if(StringUtils.isNotEmpty(data.firstName)){
            this.firstName = data.firstName;
        }
        if(StringUtils.isNotEmpty(data.secondName)){
            this.secondName = data.secondName;
        }
        if(StringUtils.isNotEmpty(data.lastName)){
            this.lastName = data.lastName;
        }
        if(StringUtils.isNotEmpty(data.secondLastName)){
            this.secondLastName = data.secondLastName;
        }
        if(StringUtils.isNotEmpty(data.birthEntityCode)){
            this.birthEntityCode = data.birthEntityCode;
        }
        if(StringUtils.isNotEmpty(data.birthEntityAdditionalCode)){
            this.birthEntityAdditionalCode = data.birthEntityAdditionalCode;
        }
        if(birthDate != null){
            this.birthDate = data.birthDate;
        }
        if(StringUtils.isNotEmpty(StringUtils.nullToString(data.email).trim())){
            this.email = data.email;
        }
        if(data.emailAddressId > 0) {
            this.emailAddressId = data.emailAddressId;
        }

        if(StringUtils.isNotEmpty(data.sex)){
            this.sex = data.sex;
        }
        if(StringUtils.isNotEmpty(data.civilStatus)){
            this.civilStatus = data.civilStatus;
        }
        if(StringUtils.isNotEmpty(data.rfc)){
            this.rfc = data.rfc;
        }
        if(StringUtils.isNotEmpty(data.curp)){
            this.curp = data.curp;
        }
        if(StringUtils.isNotEmpty(data.number)){
            this.number = data.number;
        }
        if(StringUtils.isNotEmpty(data.accountNumber)){
            this.accountNumber = data.accountNumber;
        }
        if(this.addressData ==  null){
            this.addressData = data.addressData;
        }else{
            if(data.addressData != null){
                this.addressData = data.addressData;
            }
        }
        return  this;
    }

    @Override
    public boolean isComplete() {
        boolean isComplete = true;

        if (StringUtils.isEmpty(firstName)) {
            isComplete = false;
        }

        if (StringUtils.isEmpty(lastName)) {
            isComplete = false;
        }

        if (StringUtils.isEmpty(email)) {
            isComplete = false;
        }

        if (StringUtils.isEmpty(civilStatus)) {
            isComplete = false;
        }

        if (StringUtils.isEmpty(birthEntityCode)) {
            isComplete = false;
        }

        if (StringUtils.isEmpty(sex)) {
            isComplete = false;
        }

        if (addressData == null || !addressData.isComplete()) {
            isComplete = false;
        }

        if (birthDate == null) {
            isComplete = false;
        }
        return isComplete;
    }

    public static class Builder {
        private String firstName;
        private String secondName;
        private String birthEntityCode;
        private String birthEntityAdditionalCode;
        private String lastName;
        private String secondLastName;
        private Long birthDate;
        private String email;
        private String sex;
        private String civilStatus;
        private String rfc;
        private String curp;
        private AddressData addressData;
        private String number;
        private String accountNumber;
        private int emailAddressId;

        public Builder setFirstName(String firstName) {
            this.firstName = firstName;
            return this;
        }

        public Builder setSecondName(String secondName) {
            this.secondName = secondName;
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

        public Builder setLastName(String lastName) {
            this.lastName = lastName;
            return this;
        }

        public Builder setSecondLastName(String secondLastName) {
            this.secondLastName = secondLastName;
            return this;
        }

        public Builder setBirthDate(Long birthDate) {
            this.birthDate = birthDate;
            return this;
        }

        public Builder setEmail(String email) {
            this.email = email;
            return this;
        }

        public Builder setSex(String sex) {
            this.sex = sex;
            return this;
        }

        public Builder setCivilStatus(String civilStatus) {
            this.civilStatus = civilStatus;
            return this;
        }

        public Builder setRfc(String rfc) {
            this.rfc = rfc;
            return this;
        }

        public Builder setCurp(String curp) {
            this.curp = curp;
            return this;
        }

        public Builder setAddressData(AddressData addressData) {
            this.addressData = addressData;
            return this;
        }

        public Builder setNumber(String prospectNumber) {
            number = prospectNumber;
            return this;
        }

        public Builder setAccountNumber(String prospectAccountNumber) {
            accountNumber = prospectAccountNumber;
            return this;
        }

        public Builder setEmailAddressId(int emailAddressId) {
            this.emailAddressId = emailAddressId;
            return this;
        }

        public ProspectData build() {
            return new ProspectData(this);
        }
    }
}
