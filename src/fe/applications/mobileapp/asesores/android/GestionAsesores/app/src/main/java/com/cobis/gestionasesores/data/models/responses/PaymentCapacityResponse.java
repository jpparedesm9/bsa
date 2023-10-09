package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.requests.PaymentCapacityInfo;

/**
 * Created by bqtdesa02 on 7/26/2017.
 */

public class PaymentCapacityResponse {

    private PaymentCapacityInfo paymentCapacity;

    public PaymentCapacityInfo getPaymentCapacity() {
        return paymentCapacity;
    }

    public void setPaymentCapacity(PaymentCapacityInfo paymentCapacity) {
        this.paymentCapacity = paymentCapacity;
    }
}