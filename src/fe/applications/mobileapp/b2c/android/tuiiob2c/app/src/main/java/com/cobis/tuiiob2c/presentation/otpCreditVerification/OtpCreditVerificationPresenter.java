package com.cobis.tuiiob2c.presentation.otpCreditVerification;

import com.cobis.tuiiob2c.data.models.BaseModel;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class OtpCreditVerificationPresenter implements OtpCreditVerificationMVP.OtpCreditVerificationPresenter {

    private OtpCreditVerificationMVP.OtpCreditVerificationView otpCreditVerificationView;
    private OtpCreditVerificationMVP.OtpCreditVerificationModel otpCreditVerificationModel;

    private Disposable disposable;

    public OtpCreditVerificationPresenter(OtpCreditVerificationMVP.OtpCreditVerificationModel otpCreditVerificationModel) {
        this.otpCreditVerificationModel = otpCreditVerificationModel;
    }

    @Override
    public void setView(OtpCreditVerificationMVP.OtpCreditVerificationView otpCreditVerificationView) {
        this.otpCreditVerificationView = otpCreditVerificationView;
    }

    @Override
    public void otpTokenVerification(String otp) {
        if (validatePin(otp)) {
            otpCreditVerificationView.showLoading();
            disposable = otpCreditVerificationModel.confirmOtpSolicitAmount(otp)
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribeWith(new DisposableObserver<BaseModel>() {
                        @Override
                        public void onNext(BaseModel baseModel) {
                            if (baseModel.isResult()) {
                                otpCreditVerificationView.showOtpVerificationSuccess();
                            } else {
                                otpCreditVerificationView.showOtpVerificationError(baseModel.getFirstMessage() == null ? "" : baseModel.getFirstMessage().getMessage());
                            }
                        }

                        @Override
                        public void onError(Throwable e) {
                            otpCreditVerificationView.hideLoading();
                        }

                        @Override
                        public void onComplete() {
                            otpCreditVerificationView.hideLoading();
                        }
                    });
        } else {
            otpCreditVerificationView.showErrorValidateFields();
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
