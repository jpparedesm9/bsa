package com.cobiscorp.ecobis.cloud.service.dto.spouse;

import com.cobiscorp.ecobis.cloud.service.dto.address.Phone;
import com.cobiscorp.ecobis.cloud.service.dto.business.BusinessAddress;

public class SpouseAddressData {

    private int addressId;
    private BusinessAddress address;
    private Phone workphone;
    private Phone cellphone;

    public SpouseAddressData() {
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public BusinessAddress getAddress() {
        return address;
    }

    public void setAddress(BusinessAddress address) {
        this.address = address;
    }

    public Phone getWorkphone() {
        return workphone;
    }

    public void setWorkphone(Phone workphone) {
        this.workphone = workphone;
    }

    public Phone getCellphone() {
        return cellphone;
    }

    public void setCellphone(Phone cellphone) {
        this.cellphone = cellphone;
    }
}
