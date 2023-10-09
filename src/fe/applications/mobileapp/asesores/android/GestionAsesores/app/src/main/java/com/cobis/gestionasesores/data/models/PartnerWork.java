package com.cobis.gestionasesores.data.models;

import com.bayteq.libcore.util.StringUtils;

/**
 * Created by bqtdesa02 on 6/13/2017.
 */

public class PartnerWork extends SectionData<PartnerWork> {

    private AddressData addressData;
    private String telephoneWork;
    private String cellphone;
    private int cellphoneServerId;
    private int workphoneServerId;

    private PartnerWork(Builder builder) {
        addressData = builder.addressData;
        telephoneWork = builder.telephoneWork;
        cellphone = builder.cellphone;
        cellphoneServerId = builder.cellphoneServerId;
        workphoneServerId = builder.workphoneServerId;
    }

    public AddressData getAddressData() {
        return addressData;
    }

    public String getTelephoneWork() {
        return telephoneWork;
    }

    public String getCellphone() {
        return cellphone;
    }

    public int getCellphoneServerId() {
        return cellphoneServerId;
    }

    public int getWorkphoneServerId() {
        return workphoneServerId;
    }

    public Builder buildUpon() {
        return new Builder(this);
    }

    public PartnerWork mergeIdentifierWith(PartnerWork old) {
        if (old != null) {
            if (old.getAddressData() != null) {
                getAddressData().setServerId(old.getAddressData().getServerId());
            }
            workphoneServerId = old.getWorkphoneServerId();
            cellphoneServerId = old.getCellphoneServerId();
        }
        return this;
    }

    @Override
    public PartnerWork merge(PartnerWork data) {
        throw new RuntimeException("Operation not implemented!!");
    }

    @Override
    public boolean isComplete() {
        boolean isComplete = true;

        if (addressData == null || !addressData.isComplete()) {
            isComplete = false;
        }

        if (StringUtils.isEmpty(telephoneWork)) {
            isComplete = false;
        }

        if (StringUtils.isEmpty(cellphone)) {
            isComplete = false;
        }

        return isComplete;
    }

    public static class Builder {

        private AddressData addressData;
        private String telephoneWork;
        private String cellphone;
        private int cellphoneServerId;
        private int workphoneServerId;

        public Builder() {
        }

        private Builder(PartnerWork partnerWork) {
            addressData = partnerWork.addressData;
            telephoneWork = partnerWork.telephoneWork;
            cellphone = partnerWork.cellphone;
            cellphoneServerId = partnerWork.cellphoneServerId;
            workphoneServerId = partnerWork.workphoneServerId;
        }

        public Builder addAddressData(AddressData addressData) {
            this.addressData = addressData;
            return this;
        }

        public Builder addTelephoneWork(String telephoneWork) {
            this.telephoneWork = telephoneWork;
            return this;
        }

        public Builder addCellphone(String cellphone) {
            this.cellphone = cellphone;
            return this;
        }

        public Builder addWorkphoneServerId(int workphoneServerId) {
            this.workphoneServerId = workphoneServerId;
            return this;
        }

        public Builder addCellphoneServerId(int cellphoneServerId) {
            this.cellphoneServerId = cellphoneServerId;
            return this;
        }

        public PartnerWork build() {
            return new PartnerWork(this);
        }
    }
}
