package com.cobis.gestionasesores.presentation.solidaritypayment;

import com.cobis.gestionasesores.data.models.SolidarityMember;
import com.cobis.gestionasesores.data.models.SolidarityPayment;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;
import com.cobis.gestionasesores.presentation.error.ErrorBaseContract;

import java.util.List;

public interface SolidarityPaymentContract {
    interface Presenter extends BasePresenter {
        void onSave(SolidarityPayment payment);

        void onSelectSolidarityMember(SolidarityMember solidarityMember, List<SolidarityMember> currentMembers);

        void onPaymentSet(SolidarityMember member, List<SolidarityMember> currentMembers);

        void onClickMoreInformation();
    }

    interface View extends BaseView<Presenter>, ErrorBaseContract.ErrorBaseView {
        void setSolidarityPayment(SolidarityPayment payment);

        void showSaveProgress();

        void hideSaveProgress();

        void showNetworkError();

        void showSaveError(String error);

        void showSaveSuccess(String message);

        void exit();

        void clearErrors();

        void showPaymentPrompt(SolidarityMember member, double suggestedAmount);

        void updateSolidarityMember(SolidarityMember member);

        void startMoreInformation(SolidarityPayment payment);

        void updateCoveredAmount(double coveredAmount);

        void showCoveredAmountError();

        void readOnly();
    }
}