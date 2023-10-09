package com.cobis.gestionasesores.presentation.membercredit;

import com.cobis.gestionasesores.data.models.MemberCreditApp;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

public interface MemberCreditAppContract {
    interface Presenter extends BasePresenter {

        void onClickSave(boolean isPartOfCycle,double requestAmount, double authAmount);

        void deleteFromAppRequest();

        void onComputeWarranty(double currencyValue);
    }

    interface View extends BaseView<Presenter> {

        void showRequestAmountError();

        void showMemberData(MemberCreditApp memberCredit);

        void clearErrors();

        void sendResult(MemberCreditApp memberCredit);

        void drawRiskLevel(String riskLevel);

        void hideRiskLevel();

        void toggleProposedAmount(boolean show);

        void toggleRenovation(boolean isRenovation);

        void toggleRequestView(boolean isPartOfCycle);

        void showWarrantyAmount(double warranty);
    }

}