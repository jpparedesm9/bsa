package com.cobis.tuiiob2c.presentation.phoneValidation;

import com.cobis.tuiiob2c.data.models.BaseModel;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class PhoneValidationPresenter implements PhoneValidationMVP.PhoneValidationPresenter {

    private PhoneValidationMVP.PhoneValidationView phoneValidationView;
    private PhoneValidationMVP.PhoneValidationModel phoneValidationModel;

    private Disposable disposable;

    public PhoneValidationPresenter(PhoneValidationMVP.PhoneValidationModel phoneValidationModel) {
        this.phoneValidationModel = phoneValidationModel;
    }

    @Override
    public void setView(PhoneValidationMVP.PhoneValidationView phoneValidationView) {
        this.phoneValidationView = phoneValidationView;
    }

    @Override
    public void onClickPhoneValidation(String phone) {
        if (validatePin(phone)) {
            phoneValidationView.showLoading();
            disposable = phoneValidationModel.changePhone(phone)
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribeWith(new DisposableObserver<BaseModel>() {
                        @Override
                        public void onNext(BaseModel baseModel) {
                            if (baseModel.isResult()) {
                                phoneValidationView.showPhoneValidationSuccess();
                                phoneValidationView.showValidationScreen();
                            } else {
                                phoneValidationView.showPhoneValidationError(baseModel.getFirstMessage() == null ? "" : baseModel.getFirstMessage().getMessage());
                            }
                        }

                        @Override
                        public void onError(Throwable e) {
                            phoneValidationView.hideLoading();
                        }

                        @Override
                        public void onComplete() {
                            phoneValidationView.hideLoading();
                        }
                    });
        } else {
            phoneValidationView.showErrorValidateFields();
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
