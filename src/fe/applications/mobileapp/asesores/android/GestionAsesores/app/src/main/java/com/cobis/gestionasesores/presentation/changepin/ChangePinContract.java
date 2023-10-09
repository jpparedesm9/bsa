package com.cobis.gestionasesores.presentation.changepin;

import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

/**
 * Created by jescudero on 31/08/2017.
 */

public interface ChangePinContract {
    interface Presenter extends BasePresenter{

        void handlePin(String pin);
    }
    interface View extends BaseView<Presenter>{

        void showRegisterPin();

        void showLoading();

        void hideLoading();

        void showError(String error);

        void showRegisterSuccess();

        void requestPinConfirm();
    }
}
