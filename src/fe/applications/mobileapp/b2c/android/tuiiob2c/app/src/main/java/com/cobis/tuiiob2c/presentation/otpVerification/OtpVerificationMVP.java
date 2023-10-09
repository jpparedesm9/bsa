package com.cobis.tuiiob2c.presentation.otpVerification;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.presentation.BasePresenter;
import com.cobis.tuiiob2c.presentation.BaseView;

import io.reactivex.Observable;

public interface OtpVerificationMVP {

    interface OtpVerificationModel {

        Observable<BaseModel> changePhoneOtp(String otp);
    }

    interface OtpVerificationView extends BaseView {

        void showErrorValidateFields();

        void showValidateOtpSuccess();

        void showValidateOtpError(String message);
    }

    interface OtpVerificationPresenter extends BasePresenter {

        void setView(OtpVerificationMVP.OtpVerificationView otpVerificationView);

        void onClickValidateOtp(String pin);
    }
}
