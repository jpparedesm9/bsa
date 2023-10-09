package com.cobis.tuiiob2c.presentation.otpMessageVerification;

import com.cobis.tuiiob2c.data.enums.ResponseMessageType;
import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.presentation.BasePresenter;
import com.cobis.tuiiob2c.presentation.BaseView;

import io.reactivex.Observable;

public interface OtpMessageVerificationMVP {

    interface OtpMessageVerificationModel {

        Observable<BaseModel> sendResponseMessagePin(int messageId, String response, String password);
    }

    interface OtpMessageVerificationView extends BaseView {

        void showMessageResponseSuccess();

        void showMessageResponseError(String message);
    }

    interface OtpMessageVerificationPresenter extends BasePresenter {

        void setView(OtpMessageVerificationMVP.OtpMessageVerificationView otpMessageVerificationView);

        void onSendResponseMessage(String messageId, @ResponseMessageType String response, String password);
    }
}
