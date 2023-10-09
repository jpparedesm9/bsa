package com.cobis.tuiiob2c.presentation.otpMessageVerification;

import com.cobis.tuiiob2c.data.models.BaseModel;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class OtpMessageVerificationPresenter implements OtpMessageVerificationMVP.OtpMessageVerificationPresenter {

    private OtpMessageVerificationMVP.OtpMessageVerificationView otpMessageVerificationView;
    private OtpMessageVerificationMVP.OtpMessageVerificationModel otpMessageVerificationModel;

    private Disposable disposable;

    public OtpMessageVerificationPresenter(OtpMessageVerificationMVP.OtpMessageVerificationModel otpMessageVerificationModel) {
        this.otpMessageVerificationModel = otpMessageVerificationModel;
    }

    @Override
    public void setView(OtpMessageVerificationMVP.OtpMessageVerificationView otpMessageVerificationView) {
        this.otpMessageVerificationView = otpMessageVerificationView;
    }

    @Override
    public void onSendResponseMessage(String messageId, String response, String password) {
        otpMessageVerificationView.showLoading();
        disposable = otpMessageVerificationModel.sendResponseMessagePin(Integer.parseInt(messageId), response, password)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<BaseModel>() {
                    @Override
                    public void onNext(BaseModel baseModel) {
                        if (baseModel.isResult()) {
                            otpMessageVerificationView.showMessageResponseSuccess();
                        } else {
                            otpMessageVerificationView.showMessageResponseError(baseModel.getFirstMessage() == null ? "" : baseModel.getFirstMessage().getMessage());
                        }
                    }

                    @Override
                    public void onError(Throwable e) {
                        otpMessageVerificationView.hideLoading();
                    }

                    @Override
                    public void onComplete() {
                        otpMessageVerificationView.hideLoading();
                    }
                });
    }

    @Override
    public void start() {

    }

    @Override
    public void unSuscribe() {
        if (disposable != null && !disposable.isDisposed()) {
            disposable.dispose();
        }
    }
}
