package com.cobis.gestionasesores.presentation.registerpin;

import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

/**
 * Created by jescudero on 22/08/2017.
 */

interface RegisterPinContract {
    interface RegisterPinView extends BaseView<RegisterPinPresenter> {
        void promptPinConfirm();
        void showError(String errorMessage);

        void navigateToMenu(String message);
    }

    interface RegisterPinPresenter extends BasePresenter {
        void registerPin(String pin);
    }
}
