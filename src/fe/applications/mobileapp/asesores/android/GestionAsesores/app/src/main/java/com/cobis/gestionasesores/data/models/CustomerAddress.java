package com.cobis.gestionasesores.data.models;

import com.bayteq.libcore.util.StringUtils;

/**
 * Created by bqtdesa02 on 6/13/2017.
 */

public class CustomerAddress extends SectionData<CustomerAddress> {

    private AddressData addressData;
    private String telephone;
    private String email;
    private String cellphone;
    private String yearsInCurrentAddress;
    private String housingType;
    private String numPeopleLivingInAddress;
    private int emailServerId;
    private int phoneServerId;
    private int cellphoneServerId;

    private CustomerAddress(Builder builder){
        addressData = builder.addressData;
        telephone = builder.telephone;
        email = builder.email;
        cellphone = builder.cellphone;
        yearsInCurrentAddress = builder.yearsInCurrentAddress;
        housingType = builder.housingType;
        numPeopleLivingInAddress = builder.numPeopleLivingInAddress;
        emailServerId = builder.emailServerId;
        phoneServerId = builder.phoneServerId;
        cellphoneServerId = builder.cellphoneServerId;
    }

    public AddressData getAddressData() {
        return addressData;
    }

    public String getTelephone() {
        return telephone;
    }

    public String getEmail() {
        return email;
    }

    public String getCellphone() {
        return cellphone;
    }

    public String getYearsInCurrentAddress() {
        return yearsInCurrentAddress;
    }

    public String getHousingType() {
        return housingType;
    }

    public String getNumPeopleLivingInAddress() {
        return numPeopleLivingInAddress;
    }

    public int getEmailServerId() {
        return emailServerId;
    }

    public void setEmailServerId(int emailServerId) {
        this.emailServerId = emailServerId;
    }

    public void setPhoneServerId(int phoneServerId) {
        this.phoneServerId = phoneServerId;
    }

    public void setCellphoneServerId(int cellphoneServerId) {
        this.cellphoneServerId = cellphoneServerId;
    }

    public void setAddressData(AddressData addressData) {
        this.addressData = addressData;
    }

    public int getPhoneServerId() {
        return phoneServerId;
    }

    public int getCellphoneServerId() {
        return cellphoneServerId;
    }

    public Builder buildUpon(){
        return new Builder(this);
    }

    public CustomerAddress mergeIdentifierWith(CustomerAddress old) {
        if(old != null) {
            if(old.getAddressData()!= null) {
                getAddressData().setServerId(old.getAddressData().getServerId());
            }
            emailServerId = old.getEmailServerId();
            phoneServerId = old.getPhoneServerId();
            cellphoneServerId = old.getCellphoneServerId();
        }
        return this;
    }

    @Override
    public CustomerAddress merge(CustomerAddress data) {
        throw new RuntimeException("Operation not implemented!!");
    }

    @Override
    public boolean isComplete() {
        boolean isComplete = true;

        if (addressData == null || !addressData.isComplete()) {
            isComplete = false;
        }

        if (StringUtils.isEmpty(telephone)) {
            isComplete = false;
        }

        if (StringUtils.isEmpty(email)) {
            isComplete = false;
        }

        if (StringUtils.isEmpty(cellphone)) {
            isComplete = false;
        }

        if (yearsInCurrentAddress == null || yearsInCurrentAddress.isEmpty()) {
            isComplete = false;
        }

        if (housingType == null || housingType.isEmpty()) {
            isComplete = false;
        }

        if (numPeopleLivingInAddress == null || numPeopleLivingInAddress.isEmpty()) {
            isComplete = false;
        }

        return isComplete;
    }

    public static class Builder{
        private AddressData addressData;
        private String telephone;
        private String email;
        private String cellphone;
        private String yearsInCurrentAddress;
        private String housingType;
        private String numPeopleLivingInAddress;
        private int emailServerId;
        private int phoneServerId;
        private int cellphoneServerId;

        public Builder() {
        }

        private Builder(CustomerAddress customerAddress){
            addressData = customerAddress.addressData;
            telephone = customerAddress.telephone;
            email = customerAddress.email;
            cellphone = customerAddress.cellphone;
            yearsInCurrentAddress = customerAddress.yearsInCurrentAddress;
            housingType = customerAddress.housingType;
            numPeopleLivingInAddress = customerAddress.numPeopleLivingInAddress;
            emailServerId = customerAddress.emailServerId;
            phoneServerId = customerAddress.phoneServerId;
            cellphoneServerId = customerAddress.cellphoneServerId;
        }

        public Builder addAddressData(AddressData addressData) {
            this.addressData = addressData;
            return this;
        }

        public Builder addTelephone(String telephone) {
            this.telephone = telephone;
            return this;
        }

        public Builder addEmail(String email) {
            this.email = email;
            return this;
        }

        public Builder addCellphone(String cellphone) {
            this.cellphone = cellphone;
            return this;
        }

        public Builder addYearsInCurrentAddress(String yearsInCurrentAddress) {
            this.yearsInCurrentAddress = yearsInCurrentAddress;
            return this;
        }

        public Builder addHousingType(String housingType) {
            this.housingType = housingType;
            return this;
        }

        public Builder addNumPeopleLivingInAddress(String numPeopleLivingInAddress) {
            this.numPeopleLivingInAddress = numPeopleLivingInAddress;
            return this;
        }

        public Builder addEmailServerId(int emailServerId) {
            this.emailServerId = emailServerId;
            return this;
        }

        public Builder addPhoneServerId(int phoneServerId) {
            this.phoneServerId = phoneServerId;
            return this;
        }

        public Builder addCellphoneServerId(int cellphoneServerId) {
            this.cellphoneServerId = cellphoneServerId;
            return this;
        }

        public CustomerAddress build(){
            return new CustomerAddress(this);
        }
    }
}
