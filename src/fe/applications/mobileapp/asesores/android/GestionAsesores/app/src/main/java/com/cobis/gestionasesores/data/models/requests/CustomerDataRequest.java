package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by bqtdesa02 on 7/26/2017.
 */

public class CustomerDataRequest {

    private PersonalInformationCustomer customer;
    private boolean online;

    public PersonalInformationCustomer getCustomer() {
        return customer;
    }

    public void setCustomer(PersonalInformationCustomer customer) {
        this.customer = customer;
    }

    public boolean isOnline() {
        return online;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }
}
