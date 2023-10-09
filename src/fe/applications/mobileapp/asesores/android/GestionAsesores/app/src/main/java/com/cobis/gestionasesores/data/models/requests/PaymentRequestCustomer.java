package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by mnaunay on 21/08/2017.
 */

public class PaymentRequestCustomer {
    private int customerId;
    private double amountPayWholePayment;

    public PaymentRequestCustomer(int customerId, double amountPayWholePayment) {
        this.customerId = customerId;
        this.amountPayWholePayment = amountPayWholePayment;
    }

    public int getCustomerId() {
        return customerId;
    }

    public PaymentRequestCustomer setCustomerId(int customerId) {
        this.customerId = customerId;
        return this;
    }

    public double getAmountPayWholePayment() {
        return amountPayWholePayment;
    }

    public PaymentRequestCustomer setAmountPayWholePayment(double amountPayWholePayment) {
        this.amountPayWholePayment = amountPayWholePayment;
        return this;
    }
}
