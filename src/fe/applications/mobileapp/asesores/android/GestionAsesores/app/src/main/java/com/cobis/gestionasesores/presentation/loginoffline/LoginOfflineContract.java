package com.cobis.gestionasesores.presentation.loginoffline;

import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

/**
 * Created by jescudero on 21/08/2017.
 */

public class LoginOfflineContract {
    interface LoginOfflineView extends BaseView<LoginOfflinePresenter>{
        void navigateToMenu();

        void navigateToLogin();

        void showLoading();

        void hideLoading();

        void showError(String errorMessage);

        void showChangeUserError();

        void startLoginOnline();
    }
    interface LoginOfflinePresenter extends BasePresenter{

        void validatePIN(String pin);

        void onChangeUser();

        void forgotPin();
    }
}
