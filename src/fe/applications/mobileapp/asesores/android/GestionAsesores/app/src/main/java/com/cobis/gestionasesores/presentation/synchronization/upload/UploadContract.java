package com.cobis.gestionasesores.presentation.synchronization.upload;

import android.support.annotation.StringRes;

import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

public interface UploadContract {
    interface Presenter extends BasePresenter {
        void startSynchronization(boolean[] items);

        void registerReceiver();

        void unregisterReceiver();

        void onTryToExit();

        boolean handleMenuSettings();

        void onSelectUploadItems(boolean[] uploadItems);

        void onClickFinish();
    }

    interface View extends BaseView<Presenter> {

        void appendDetail(String message);

        void appendDetailWithResourceArg(@StringRes int message, int type, Object... formatArgs);

        void replaceLastDetailWithResourceArg(@StringRes int message, int type, Object... formatArgs);

        void appendDetail(@StringRes int message, Object... formatArgs);

        void replaceLastDetail(@StringRes int message, Object... formatArgs);

        void clearDetails();

        void showProgressBar();

        void hideProgressBar();

        void showLoading();

        void hideLoading();

        void setSyncText(@StringRes int message, Object... formatArgs);

        void copyLastDetail();

        void showSyncRunning();

        void exit();

        void openMenuSettings();

        String[] getUploadItems();

        void showFinish(boolean show);

        void showFinishSuccess();
    }
}
