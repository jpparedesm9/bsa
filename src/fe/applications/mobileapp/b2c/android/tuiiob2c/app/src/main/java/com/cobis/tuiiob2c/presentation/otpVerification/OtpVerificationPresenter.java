package com.cobis.tuiiob2c.presentation.otpVerification;

import com.cobis.tuiiob2c.data.models.BaseModel;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class OtpVerificationPresenter implements OtpVerificationMVP.OtpVerificationPresenter {

    private OtpVerificationMVP.OtpVerificationView otpVerificationView;
    private OtpVerificationMVP.OtpVerificationModel otpVerificationModel;

    private Disposable disposable;

    public OtpVerificationPresenter(OtpVerificationMVP.OtpVerificationModel otpVerificationModel) {
        this.otpVerificationModel = otpVerificationModel;
    }

    @Override
    public void setView(OtpVerificationMVP.OtpVerificationView otpVerificationView) {
        this.otpVerificationView = otpVerificationView;
    }

    @Override
    public void onClickValidateOtp(String pin) {
        if (validatePin(pin)) {
            otpVerificationView.showLoading();
            disposable = otpVerificationModel.changePhoneOtp(pin)
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribeWith(new DisposableObserver<BaseModel>() {
                        @Override
                        public void onNext(BaseModel baseModel) {
                            if (baseModel.isResult()) {
                                otpVerificationView.showValidateOtpSuccess();
                            } else {
                                otpVerificationView.showValidateOtpError(baseModel.getFirstMessage() == null ? "" : baseModel.getFirstMessage().getMessage());
                            }
                        }

                        @Override
                        public void onError(Throwable e) {
                            otpVerificationView.hideLoading();
                        }

                        @Override
                        public void onComplete() {
                            otpVerificationView.hideLoading();
                        }
                    });
        } else {
            otpVerificationView.showErrorValidateFields();
        }
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

    private boolean validatePin(String pin) {
        return pin != null && !pin.isEmpty();
    }
}
