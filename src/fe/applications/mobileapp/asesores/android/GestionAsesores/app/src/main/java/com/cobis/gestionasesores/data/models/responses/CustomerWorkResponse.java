package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by bqtdesa02 on 7/26/2017.
 */

public class CustomerWorkResponse {

    private BusinessResponse business;
    private AddressResponse address;

    public BusinessResponse getBusiness() {
        return business;
    }

    public void setBusiness(BusinessResponse business) {
        this.business = business;
    }

    public AddressResponse getAddress() {
        return address;
    }
}
