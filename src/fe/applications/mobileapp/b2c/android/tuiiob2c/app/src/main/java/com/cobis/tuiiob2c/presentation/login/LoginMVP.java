package com.cobis.tuiiob2c.presentation.login;

import com.cobis.tuiiob2c.data.enums.Environment;
import com.cobis.tuiiob2c.data.models.responses.AuthResponse;
import com.cobis.tuiiob2c.presentation.BasePresenter;
import com.cobis.tuiiob2c.presentation.BaseView;

import io.reactivex.Observable;

public interface LoginMVP {

    interface LoginModel {

        Observable<AuthResponse> validatePin(String phoneNumber, String pin);
    }

    interface LoginView extends BaseView {

        void showAuthSuccess();

        void showAuthError(String message);

        void showVersionInfo(String versionName, String versionCode);

        void setEnvironment(Environment environment);

        void showEnvironmentSelector(boolean shouldShow);

        void restartAppForEnviroment();

        void showUserLocked();
    }

    interface LoginPresenter extends BasePresenter {

        void setView(LoginMVP.LoginView loginView);

        void onClickValidatePin(String pin);

        void onEnvironmentSelected(Environment environment);
    }
}
