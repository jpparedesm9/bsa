package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by bqtdesa02 on 7/26/2017.
 */

public class PaymentCapacityRequest {

    private PaymentCapacityInfo paymentCapacity;
    private boolean online;

    public PaymentCapacityInfo getPaymentCapacity() {
        return paymentCapacity;
    }

    public void setPaymentCapacity(PaymentCapacityInfo paymentCapacity) {
        this.paymentCapacity = paymentCapacity;
    }

    public boolean isOnline() {
        return online;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }
}
