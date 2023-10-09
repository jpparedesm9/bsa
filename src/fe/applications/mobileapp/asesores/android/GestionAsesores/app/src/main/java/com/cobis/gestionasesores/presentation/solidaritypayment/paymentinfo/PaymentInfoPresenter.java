package com.cobis.gestionasesores.presentation.solidaritypayment.paymentinfo;

import com.cobis.gestionasesores.data.models.SolidarityPayment;

public class PaymentInfoPresenter implements PaymentInfoContract.Presenter {

    private PaymentInfoContract.View mView;

    private SolidarityPayment mSolidarityPayment;

    public PaymentInfoPresenter(PaymentInfoContract.View view, SolidarityPayment solidarityPayment) {
        mView = view;
        mSolidarityPayment = solidarityPayment;

        mView.setPresenter(this);
    }

    @Override
    public void start() {
        mView.setSolidarityPayment(mSolidarityPayment);
    }
}