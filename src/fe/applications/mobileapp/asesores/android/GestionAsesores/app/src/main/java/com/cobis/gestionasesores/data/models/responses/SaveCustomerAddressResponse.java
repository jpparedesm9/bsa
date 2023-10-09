package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by bqtdesa02 on 7/28/2017.
 */

public class SaveCustomerAddressResponse {

    private AddressResponse address;
    private EmailAddressResponse email;
    private PhoneInfoResponse phone;
    private PhoneInfoResponse cellphone;
    private GeoReferenceResponse geoReference;


    public AddressResponse getAddress() {
        return address;
    }

    public void setAddress(AddressResponse address) {
        this.address = address;
    }

    public EmailAddressResponse getEmail() {
        return email;
    }

    public void setEmail(EmailAddressResponse email) {
        this.email = email;
    }

    public PhoneInfoResponse getPhone() {
        return phone;
    }

    public void setPhone(PhoneInfoResponse phone) {
        this.phone = phone;
    }

    public PhoneInfoResponse getCellphone() {
        return cellphone;
    }

    public void setCellphone(PhoneInfoResponse cellphone) {
        this.cellphone = cellphone;
    }

    public GeoReferenceResponse getGeoReference() {
        return geoReference;
    }

    public void setGeoReference(GeoReferenceResponse geoReference) {
        this.geoReference = geoReference;
    }
}
