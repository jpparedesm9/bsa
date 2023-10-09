package com.cobiscorp.ecobis.cloud.service.dto.address;

/**
 * @author Cesar Loachamin
 */
public class AddressResult {

    private Integer addressId;

    public AddressResult() {
    }

    public AddressResult(Integer addressId) {
        this.addressId = addressId;
    }

    public Integer getAddressId() {
        return addressId;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
    }
}
