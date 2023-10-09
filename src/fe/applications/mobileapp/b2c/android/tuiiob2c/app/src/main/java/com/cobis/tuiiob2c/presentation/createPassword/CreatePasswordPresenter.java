package com.cobis.tuiiob2c.presentation.createPassword;

import com.cobis.tuiiob2c.data.models.BaseModel;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class CreatePasswordPresenter implements CreatePasswordMVP.CreatePasswordPresenter {

    private CreatePasswordMVP.CreatePasswordView createPasswordView;
    private CreatePasswordMVP.CreatePasswordModel createPasswordModel;

    private Disposable disposable;

    public CreatePasswordPresenter(CreatePasswordMVP.CreatePasswordModel createPasswordModel) {
        this.createPasswordModel = createPasswordModel;
    }

    @Override
    public void setView(CreatePasswordMVP.CreatePasswordView createPasswordView) {
        this.createPasswordView = createPasswordView;
    }

    @Override
    public void onClickValidateCreatePassword(String password, String repeatPassword) {
        if (validatePasswords(password, repeatPassword)) {
            createPasswordView.showLoading();
            disposable = createPasswordModel.validateCreatePassword(password)
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribeWith(new DisposableObserver<BaseModel>() {
                        @Override
                        public void onNext(BaseModel baseModel) {
                            if (baseModel.isResult()) {
                                createPasswordView.showCreatePasswordSuccess();
                            } else {
                                createPasswordView.showCreatePasswordError(baseModel.getFirstMessage() == null ? "" : baseModel.getFirstMessage().getMessage());
                            }
                        }

                        @Override
                        public void onError(Throwable e) {
                            createPasswordView.hideLoading();
                        }

                        @Override
                        public void onComplete() {
                            createPasswordView.hideLoading();
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
            createPasswordView.showCreatePasswordError("La clave debe ser de 4 digitos");
            return  false;
        } else if (password.compareTo(repeatPassword) != 0) {
            createPasswordView.showCreatePasswordError("Las contraseñas no coinciden");
            return false;
        } else {
            return true;
        }
    }
}
