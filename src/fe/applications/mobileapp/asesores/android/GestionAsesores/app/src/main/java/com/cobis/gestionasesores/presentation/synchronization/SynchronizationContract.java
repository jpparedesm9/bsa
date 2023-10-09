package com.cobis.gestionasesores.presentation.synchronization;

import android.support.annotation.StringRes;

import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

public interface SynchronizationContract {
    interface Presenter extends BasePresenter {
        void synchronizeDown();

        void registerReceiver();

        void unregisterReceiver();

        void onTryToExit();

        void synchronizeCatalog();

        void startSyncUp();

        void onContinue();
    }

    interface View extends BaseView<Presenter> {
        void setSyncUpTime(@StringRes int message, Object... formatArgs);

        void setSyncDownTime(@StringRes int message, Object... formatArgs);

        void startSyncAnimation(@StringRes int message, Object... formatArgs);

        void stopSyncAnimation(@StringRes int message, Object... formatArgs);

        void showCatalogsSync();

        void showCatalogsSynced(@StringRes int message, Object... formatArgs);

        void showCatalogSyncError();

        void startSyncUp();

        void showSyncRunning();

        void showRetryPlease();

        void exit();

        void showContinue(boolean shouldShow, boolean tryAgain);

        void setSyncCatalogTime(@StringRes int message, Object... formatArgs);

        void showSyncDownloadError();

        void showSyncItemError(int errorId);
    }
}
