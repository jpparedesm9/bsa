package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by bqtdesa02 on 7/27/2017.
 */

public class EmailAddress {

    private int addressId;
    private String email;

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
