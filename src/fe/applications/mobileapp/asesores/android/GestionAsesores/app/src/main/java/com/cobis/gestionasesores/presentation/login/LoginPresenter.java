package com.cobis.gestionasesores.presentation.login;

import android.support.annotation.NonNull;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.BuildConfig;
import com.cobis.gestionasesores.data.enums.Environment;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.domain.usecases.LoginUseCase;
import com.cobis.gestionasesores.infrastructure.SessionManager;
import com.cobis.gestionasesores.utils.Util;

import io.reactivex.observers.DisposableObserver;

public class LoginPresenter implements LoginContract.Presenter {
    private LoginContract.View mView;
    private LoginUseCase mLoginUseCase;

    public LoginPresenter(LoginContract.View view, LoginUseCase loginUseCase) {
        mView = view;
        mLoginUseCase = loginUseCase;
        mView.setPresenter(this);
    }

    @Override
    public void start() {
        mView.showEnvironmentSelector(BankAdvisorApp.getInstance().getConfig().isEnvironmentSelectorEnabled());
        mView.setEnvironment(BankAdvisorApp.getInstance().getConfig().getEnvironment());
        mView.showVersionInfo(BuildConfig.VERSION_NAME, String.valueOf(BuildConfig.VERSION_CODE));
        if(BuildConfig.DEBUG){
            mView.setUserName(BuildConfig.USER);
            mView.setPassword(BuildConfig.PASSWORD);
        }
    }

    @Override
    public void validateCredentials(@NonNull String userName, @NonNull String password) {
        mView.clearErrors();
        if (isValidData(userName, password)) {
            mView.showLoading();
            mLoginUseCase.execute(new LoginUseCase.Params(userName, password, true), new DisposableObserver<ResultData>() {
                @Override
                public void onNext(@io.reactivex.annotations.NonNull ResultData result) {
                    if (result.getType() == ResultType.SUCCESS) {
                        if (result.getErrorMessage() == null) {
                            navigateView((Boolean) result.getData());
                        } else {
                            mView.showMessageError(result.getErrorMessage(), (Boolean) result.getData());
                        }

                    } else {
                        mView.showError(result.getErrorMessage());
                    }
                }

                @Override
                public void onError(@NonNull Throwable e) {
                    Log.e("Login error: ",e);
                    mView.hideLoading();
                    if (Util.isNetworkError(e)) {
                        mView.showNetworkError();
                    } else {
                        mView.showError();
                    }
                }

                @Override
                public void onComplete() {
                    mView.hideLoading();
                }
            });
        }
    }

    @Override
    public void onEnvironmentSelected(Environment environment) {
        SessionManager.getInstance().saveLastEnviromentSwitch(environment);
        BankAdvisorApp.getInstance().setEnvironment(environment);
    }

    private boolean isValidData(String userName, String password) {
        boolean isValid = true;
        if (StringUtils.isEmpty(userName)) {
            mView.showUserNameError();
            isValid = false;
        }
        if (StringUtils.isEmpty(password)) {
            mView.showPasswordError();
            isValid = false;
        }
        return isValid;
    }

    @Override
    public void navigateView(boolean isRegistered) {
        if (isRegistered) {
            if (SessionManager.getInstance().existPin()) {
                mView.navigateMenu();
            } else {
                mView.navigateToRegisterPin();
            }
        } else {
            mView.navigateToRegister();
        }
    }
}