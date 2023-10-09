package com.cobis.gestionasesores.presentation.solidaritypayment.paymentinfo;

import com.cobis.gestionasesores.data.models.SolidarityPayment;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

public interface PaymentInfoContract {
    interface Presenter extends BasePresenter {

    }

    interface View extends BaseView<Presenter> {
        void setSolidarityPayment(SolidarityPayment payment);
    }

}