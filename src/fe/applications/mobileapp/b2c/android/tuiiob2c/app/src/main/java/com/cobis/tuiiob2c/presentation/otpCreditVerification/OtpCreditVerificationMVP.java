package com.cobis.tuiiob2c.presentation.otpCreditVerification;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.presentation.BasePresenter;
import com.cobis.tuiiob2c.presentation.BaseView;

import io.reactivex.Observable;

public interface OtpCreditVerificationMVP {

    interface OtpCreditVerificationModel {

        Observable<BaseModel> confirmOtpSolicitAmount(String otp);
    }

    interface OtpCreditVerificationView extends BaseView {

        void showErrorValidateFields();

        void showOtpVerificationSuccess();

        void showOtpVerificationError(String message);
    }

    interface OtpCreditVerificationPresenter extends BasePresenter {

        void setView(OtpCreditVerificationMVP.OtpCreditVerificationView otpCreditVerificationView);

        void otpTokenVerification(String otp);
    }
}
