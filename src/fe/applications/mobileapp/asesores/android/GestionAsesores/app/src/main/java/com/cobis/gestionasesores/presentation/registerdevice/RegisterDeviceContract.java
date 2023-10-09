package com.cobis.gestionasesores.presentation.registerdevice;

import android.support.annotation.NonNull;

import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

/**
 * Created by jescudero on 8/19/2017.
 */

interface RegisterDeviceContract {
    interface RegisterDeviceView extends BaseView<RegisterDevicePresenter> {
        void showLoading();

        void hideLoading();

        void navigateToRegisterPin(String message);

        void showError(String errorMessage);

        void showErrorLength(int min, int max);

        void clearError();

        void showNetworkError();
    }

    interface RegisterDevicePresenter extends BasePresenter {
        void registerDevice(@NonNull String alias);
    }
}
