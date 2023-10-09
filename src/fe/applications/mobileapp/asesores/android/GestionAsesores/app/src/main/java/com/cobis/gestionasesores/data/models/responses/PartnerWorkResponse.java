package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by bqtdesa02 on 7/26/2017.
 */

public class PartnerWorkResponse {

    private PartnerWorkAddressResponse address;
    private PhoneInfoResponse workphone;
    private PhoneInfoResponse cellphone;

    public PartnerWorkAddressResponse getAddress() {
        return address;
    }

    public void setAddress(PartnerWorkAddressResponse address) {
        this.address = address;
    }

    public PhoneInfoResponse getWorkphone() {
        return workphone;
    }

    public void setWorkphone(PhoneInfoResponse workphone) {
        this.workphone = workphone;
    }

    public PhoneInfoResponse getCellphone() {
        return cellphone;
    }

    public void setCellphone(PhoneInfoResponse cellphone) {
        this.cellphone = cellphone;
    }
}
