package com.cobis.gestionasesores.presentation.login;

import android.support.annotation.NonNull;

import com.cobis.gestionasesores.data.enums.Environment;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

/**
 *
 * Created by mnaunay on 02/06/2017.
 */
public class LoginContract {
    interface View extends BaseView<Presenter> {
        void navigateMenu();

        void clearErrors();

        void showUserNameError();

        void showPasswordError();

        void showLoading();

        void showError();

        void showMessageError(String message, boolean isRegistered);

        void hideLoading();

        void setEnvironment(Environment environment);

        void showEnvironmentSelector(boolean shouldShow);

        void showVersionInfo(String versionName, String versionCode);

        void setUserName(String userName);

        void setPassword(String password);

        void navigateToRegister();

        void navigateToRegisterPin();

        void showError(String message);

        void showNetworkError();
    }

    interface Presenter extends BasePresenter {
        void validateCredentials(@NonNull String userName, @NonNull String password);
        void onEnvironmentSelected(Environment environment);
        void navigateView(boolean isRegistered);
    }

}
