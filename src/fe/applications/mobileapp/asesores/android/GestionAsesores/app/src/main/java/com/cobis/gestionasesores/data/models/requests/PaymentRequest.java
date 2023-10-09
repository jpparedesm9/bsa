package com.cobis.gestionasesores.data.models.requests;

import java.util.List;

public class PaymentRequest {
    private PaymentRequestData solidarityPaymentData;
    private List<PaymentRequestCustomer> solidarityPaymentCustomerData;
    private boolean online;

    public PaymentRequestData getSolidarityPaymentData() {
        return solidarityPaymentData;
    }

    public PaymentRequest setSolidarityPaymentData(PaymentRequestData solidarityPaymentData) {
        this.solidarityPaymentData = solidarityPaymentData;
        return this;
    }

    public List<PaymentRequestCustomer> getSolidarityPaymentCustomerData() {
        return solidarityPaymentCustomerData;
    }

    public PaymentRequest setSolidarityPaymentCustomerData(List<PaymentRequestCustomer> solidarityPaymentCustomerData) {
        this.solidarityPaymentCustomerData = solidarityPaymentCustomerData;
        return this;
    }

    public boolean isOnline() {
        return online;
    }

    public PaymentRequest setOnline(boolean online) {
        this.online = online;
        return this;
    }
}
