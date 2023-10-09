package com.cobis.tuiiob2c.presentation.changePassword;

import com.cobis.tuiiob2c.data.models.BaseModel;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class ChangePasswordPresenter implements ChangePasswordMVP.ChangePasswordPresenter {

    private ChangePasswordMVP.ChangePasswordView changePasswordView;
    private ChangePasswordMVP.ChangePasswordModel changePasswordModel;

    private Disposable disposable;

    public ChangePasswordPresenter(ChangePasswordMVP.ChangePasswordModel changePasswordModel) {
        this.changePasswordModel = changePasswordModel;
    }

    @Override
    public void setView(ChangePasswordMVP.ChangePasswordView changePasswordView) {
        this.changePasswordView = changePasswordView;
    }

    @Override
    public void onClickValidateCreatePassword(String oldPassword, String password, String repeatPassword) {
        if (validatePasswords(oldPassword, password, repeatPassword)) {
            changePasswordView.showLoading();
            disposable = changePasswordModel.validateChangePassword(oldPassword, password)
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribeWith(new DisposableObserver<BaseModel>() {
                        @Override
                        public void onNext(BaseModel baseModel) {
                            if (baseModel.isResult()) {
                                changePasswordView.showChangePasswordSuccess();
                            } else {
                                changePasswordView.showChangePasswordError(baseModel.getFirstMessage() == null ? "" : baseModel.getFirstMessage().getMessage());
                            }
                        }

                        @Override
                        public void onError(Throwable e) {
                            changePasswordView.hideLoading();
                        }

                        @Override
                        public void onComplete() {
                            changePasswordView.hideLoading();
                        }
                    });
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

    private boolean validatePasswords(String oldPassword, String password, String repeatPassword) {
        if (password == null || password.isEmpty() || repeatPassword == null || repeatPassword.isEmpty() || password.length() != 4 || oldPassword == null || oldPassword.isEmpty() || oldPassword.length() != 4) {
            changePasswordView.showChangePasswordError("La clave debe ser de 4 digitos");
            return  false;
        } else if (password.compareTo(repeatPassword) != 0) {
            changePasswordView.showChangePasswordError("Las contraseñas no coinciden");
            return false;
        } else {
            return true;
        }
    }
}
