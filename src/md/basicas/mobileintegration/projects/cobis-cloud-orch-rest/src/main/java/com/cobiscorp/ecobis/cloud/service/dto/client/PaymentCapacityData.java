package com.cobiscorp.ecobis.cloud.service.dto.client;

public class PaymentCapacityData {

    private PaymentCapacity paymentCapacity;

    public PaymentCapacityData() {
    }

    public PaymentCapacityData(PaymentCapacity paymentCapacity) {
        this.paymentCapacity = paymentCapacity;
    }

    public PaymentCapacity getPaymentCapacity() {
        return paymentCapacity;
    }

    public void setPaymentCapacity(PaymentCapacity paymentCapacity) {
        this.paymentCapacity = paymentCapacity;
    }
}
