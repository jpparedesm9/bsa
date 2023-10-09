package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.requests.PersonalInformationCustomer;

/**
 * Created by bqtdesa02 on 7/27/2017.
 */

public class CustomerDataResponse {

    private PersonalInformationCustomer customer;

    public PersonalInformationCustomer getCustomer() {
        return customer;
    }

    public void setCustomer(PersonalInformationCustomer customer) {
        this.customer = customer;
    }
}
