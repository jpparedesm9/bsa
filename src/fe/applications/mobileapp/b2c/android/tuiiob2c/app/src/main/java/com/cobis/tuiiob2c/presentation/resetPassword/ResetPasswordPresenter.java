package com.cobis.tuiiob2c.presentation.resetPassword;

import com.cobis.tuiiob2c.data.models.BaseModel;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class ResetPasswordPresenter implements ResetPasswordMVP.ResetPasswordPresenter {

    private ResetPasswordMVP.ResetPasswordView resetPasswordView;
    private ResetPasswordMVP.ResetPasswordModel resetPasswordModel;

    private Disposable disposable;

    public ResetPasswordPresenter(ResetPasswordMVP.ResetPasswordModel resetPasswordModel) {
        this.resetPasswordModel = resetPasswordModel;
    }

    @Override
    public void setView(ResetPasswordMVP.ResetPasswordView resetPasswordView) {
        this.resetPasswordView = resetPasswordView;
    }

    @Override
    public void onClickValidateResetPassword(String password, String repeatPassword) {
        if (validatePasswords(password, repeatPassword)) {
            resetPasswordView.showLoading();
            disposable = resetPasswordModel.validateResetPassword(password)
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribeWith(new DisposableObserver<BaseModel>() {
                        @Override
                        public void onNext(BaseModel baseModel) {
                            if (baseModel.isResult()) {
                                resetPasswordView.showResetPasswordSuccess();
                            } else {
                                resetPasswordView.showResetPasswordError(baseModel.getFirstMessage() == null ? "" : baseModel.getFirstMessage().getMessage());
                            }
                        }

                        @Override
                        public void onError(Throwable e) {
                            resetPasswordView.hideLoading();
                        }

                        @Override
                        public void onComplete() {
                            resetPasswordView.hideLoading();
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

    private boolean validatePasswords(String password, String repeatPassword) {
        if (password == null || password.isEmpty() || repeatPassword == null || repeatPassword.isEmpty() || password.length() != 4) {
            resetPasswordView.showResetPasswordError("La clave debe ser de 4 digitos");
            return  false;
        } else if (password.compareTo(repeatPassword) != 0) {
            resetPasswordView.showResetPasswordError("Las contraseñas no coinciden");
            return false;
        } else {
            return true;
        }
    }
}
