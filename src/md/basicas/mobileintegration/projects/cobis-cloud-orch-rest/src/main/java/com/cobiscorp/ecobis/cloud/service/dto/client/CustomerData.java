package com.cobiscorp.ecobis.cloud.service.dto.client;

public class CustomerData {

    private Customer customer;

    public CustomerData() {
    }

    public CustomerData(Customer customer) {
        this.customer = customer;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
}
