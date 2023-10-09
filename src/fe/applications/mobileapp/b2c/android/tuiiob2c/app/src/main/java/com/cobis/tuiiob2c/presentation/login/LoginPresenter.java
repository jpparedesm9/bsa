package com.cobis.tuiiob2c.presentation.login;

import com.cobis.tuiiob2c.BuildConfig;
import com.cobis.tuiiob2c.data.enums.Environment;
import com.cobis.tuiiob2c.data.models.responses.AuthResponse;
import com.cobis.tuiiob2c.infraestructure.SessionManager;
import com.cobis.tuiiob2c.root.App;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.Disposable;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class LoginPresenter implements LoginMVP.LoginPresenter {

    private LoginMVP.LoginView loginView;
    private LoginMVP.LoginModel loginModel;

    private Disposable disposable;

    public LoginPresenter(LoginMVP.LoginModel loginModel) {
        this.loginModel = loginModel;
    }

    @Override
    public void setView(LoginMVP.LoginView loginView) {
        this.loginView = loginView;
    }

    @Override
    public void onClickValidatePin(String pin) {
        if (validatePin(pin)) {
            loginView.showLoading();
            disposable = loginModel.validatePin(SessionManager.getInstance().getValuesEnrollment().getTelefono(), pin)
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribeWith(new DisposableObserver<AuthResponse>() {
                        @Override
                        public void onNext(AuthResponse authResponse) {
                            if (authResponse.isResult()) {
                                loginView.showAuthSuccess();
                            } else if (authResponse.getResponseCode() == 403) {
                                loginView.showUserLocked();
                            } else {
                                loginView.showAuthError(authResponse.getFirstMessage() == null ? "" : authResponse.getFirstMessage().getMessage());
                            }
                        }

                        @Override
                        public void onError(Throwable e) {
                            loginView.hideLoading();
                        }

                        @Override
                        public void onComplete() {
                            loginView.hideLoading();
                        }
                    });
        }
    }

    @Override
    public void onEnvironmentSelected(Environment environment) {
        SessionManager.getInstance().saveLastEnviromentSwitch(environment);
        App.getInstance().setEnvironment(environment);
        loginView.restartAppForEnviroment();
    }

    @Override
    public void start() {
        loginView.showVersionInfo(BuildConfig.VERSION_NAME, String.valueOf(BuildConfig.VERSION_CODE));
        loginView.showEnvironmentSelector(App.getInstance().getConfig().isEnvironmentSelectorEnabled());
        loginView.setEnvironment(App.getInstance().getConfig().getEnvironment());
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
