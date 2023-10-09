package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by bqtdesa02 on 7/26/2017.
 */

public class SaveCustomerDataResponse {
    private GeneralDataResponse customer;

    public GeneralDataResponse getCustomer() {
        return customer;
    }

    public void setCustomer(GeneralDataResponse customer) {
        this.customer = customer;
    }
}
