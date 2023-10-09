package com.cobis.gestionasesores.presentation.loginoffline;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.NetworkUtils;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.domain.usecases.LoginUseCase;
import com.cobis.gestionasesores.infrastructure.SessionManager;

import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;

/**
 * Created by jescudero on 21/08/2017.
 */

public class LoginOfflinePresenter implements LoginOfflineContract.LoginOfflinePresenter {

    private LoginOfflineContract.LoginOfflineView mView;
    private LoginUseCase mLoginUseCase;

    public LoginOfflinePresenter(LoginOfflineContract.LoginOfflineView view, LoginUseCase useCase) {
        mView = view;
        mLoginUseCase = useCase;
        mView.setPresenter(this);
    }

    @Override
    public void start() {
    }

    @Override
    public void validatePIN(String pin) {
        mView.showLoading();
        mLoginUseCase.execute(new LoginUseCase.Params(SessionManager.getInstance().getLastUserLogin(), pin, false), new DisposableObserver<ResultData>() {
            @Override
            public void onNext(@NonNull ResultData result) {
                if (result.getType() == ResultType.SUCCESS) {
                    mView.navigateToMenu();
                } else {
                    mView.showError(result.getErrorMessage());
                }
            }

            @Override
            public void onError(@NonNull Throwable e) {
                Log.e("Login validatePIN error: ", e);
                mView.hideLoading();
                mView.showError(null);
            }

            @Override
            public void onComplete() {
                mView.hideLoading();
            }
        });
    }

    @Override
    public void onChangeUser() {
        if (NetworkUtils.isOnline()) {
            mView.startLoginOnline();
        } else {
            mView.showChangeUserError();
        }
    }

    @Override
    public void forgotPin() {
        SessionManager sessionManager = SessionManager.getInstance();
        String userName = sessionManager.getLastUserLogin();
        SessionManager.getInstance().removePin(userName);
        mView.navigateToLogin();
    }
}
