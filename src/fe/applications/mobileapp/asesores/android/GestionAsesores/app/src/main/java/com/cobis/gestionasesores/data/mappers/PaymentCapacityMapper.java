package com.cobis.gestionasesores.data.mappers;

import android.support.annotation.NonNull;

import com.cobis.gestionasesores.data.models.CustomerPayment;
import com.cobis.gestionasesores.data.models.requests.PaymentCapacityInfo;
import com.cobis.gestionasesores.data.models.requests.PaymentCapacityRequest;
import com.cobis.gestionasesores.data.models.responses.PaymentCapacityResponse;

/**
 * Created by bqtdesa02 on 7/28/2017.
 */

public class PaymentCapacityMapper {

    public static PaymentCapacityRequest customerPaymentToRequest(@NonNull CustomerPayment customerPayment, boolean isSync){
        PaymentCapacityInfo paymentCapacityInfo = new PaymentCapacityInfo();
        paymentCapacityInfo.setMonthlyBusinessExpenses(customerPayment.getMonthlyBusinessExpenses());
        paymentCapacityInfo.setMonthlyFamilyExpense(customerPayment.getMonthlyFamilyExpenses());
        paymentCapacityInfo.setMonthlyIncome(customerPayment.getMonthlyIncome());

        PaymentCapacityRequest paymentCapacityRequest = new PaymentCapacityRequest();
        paymentCapacityRequest.setOnline(!isSync);
        paymentCapacityRequest.setPaymentCapacity(paymentCapacityInfo);
        return paymentCapacityRequest;
    }


    public static CustomerPayment responseToCustomerPayment(PaymentCapacityResponse response){
        PaymentCapacityInfo paymentCapacityInfo = response.getPaymentCapacity();

        return new CustomerPayment.Builder()
                .addMonthlyBusinessExpenses(paymentCapacityInfo.getMonthlyBusinessExpenses())
                .addMonthlyFamilyExpenses(paymentCapacityInfo.getMonthlyFamilyExpense())
                .addMonthlyIncome(paymentCapacityInfo.getMonthlyIncome())
                .build();
    }
}
