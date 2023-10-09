package com.cobis.gestionasesores.presentation.groupverification;

import com.cobis.gestionasesores.data.models.MemberVerification;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;
import com.cobis.gestionasesores.presentation.error.ErrorBaseContract;

import java.util.List;

public interface GroupVerificationContract {
    interface View extends BaseView<Presenter>, ErrorBaseContract.ErrorBaseView {
        void showGroupName(String name);

        void showMemberVerifications(List<MemberVerification> memberVerifications);

        void startMemberVerification(int verificationId, MemberVerification memberVerification);

        void showLoadError();

        void showLoadProgress();

        void hideProgress();

        void showMessageValidatedSuccess();

        void showErrorValidate(String errorMessage);

        void showTitle(String VerificationType);
    }

    interface Presenter extends BasePresenter {

        void onMemberVerificationResult();

        void onMemberVerificationSelected(MemberVerification member);
    }
}
