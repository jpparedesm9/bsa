package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by bqtdesa02 on 7/26/2017.
 */

public class CustomerAddressRequest {
    private int addressId;
    private AddressInfo address;
    private EmailAddress emailAddress;
    private PhoneInfo phone;
    private PhoneInfo cellphone;
    private GeoReference geoReference;
    private GeoReference officialGeoReference;
    private boolean online;

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public AddressInfo getAddress() {
        return address;
    }

    public void setAddress(AddressInfo address) {
        this.address = address;
    }

    public EmailAddress getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(EmailAddress emailAddress) {
        this.emailAddress = emailAddress;
    }

    public PhoneInfo getPhone() {
        return phone;
    }

    public void setPhone(PhoneInfo phone) {
        this.phone = phone;
    }

    public PhoneInfo getCellphone() {
        return cellphone;
    }

    public void setCellphone(PhoneInfo cellphone) {
        this.cellphone = cellphone;
    }

    public boolean isOnline() {
        return online;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }

    public GeoReference getGeoReference() {
        return geoReference;
    }

    public void setGeoReference(GeoReference geoReference) {
        this.geoReference = geoReference;
    }

    public GeoReference getOfficialGeoReference() {
        return officialGeoReference;
    }

    public CustomerAddressRequest setOfficialGeoReference(GeoReference officialGeoReference) {
        this.officialGeoReference = officialGeoReference;
        return this;
    }
}
