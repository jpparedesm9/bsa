package com.cobis.gestionasesores.presentation.synchronization;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.content.LocalBroadcastManager;

import com.bayteq.libcore.LibCore;
import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.domain.businesslogic.InitManager;
import com.cobis.gestionasesores.domain.usecases.InitializeAppUseCase;
import com.cobis.gestionasesores.infrastructure.SessionManager;
import com.cobis.gestionasesores.infrastructure.SyncManager;
import com.cobis.gestionasesores.utils.DateUtils;

import io.reactivex.observers.DisposableObserver;

public class SynchronizationPresenter implements SynchronizationContract.Presenter {

    private SynchronizationContract.View mView;
    private SessionManager manager;

    private InitializeAppUseCase mInitializeAppUseCase;

    private boolean mIsForcedOpen;

    private boolean isSyncRunning;

    private boolean canFinish;

    public SynchronizationPresenter(SynchronizationContract.View view, InitializeAppUseCase initializeAppUseCase, boolean isForcedOpen) {
        mView = view;
        mInitializeAppUseCase = initializeAppUseCase;
        mIsForcedOpen = isForcedOpen;
        mView.setPresenter(this);
    }

    @Override
    public void start() {
        manager = SessionManager.getInstance();

        SyncManager.trySync();

        if (manager.getLastSyncUp() <= 0) {
            mView.setSyncUpTime(R.string.sync_message_never);
        } else {
            mView.setSyncUpTime(R.string.sync_message_completed, DateUtils.formatDateForSync(manager.getLastSyncUp()));
        }

        if (manager.getLastSyncDown() <= 0) {
            mView.setSyncDownTime(R.string.sync_message_never);
        } else {
            mView.setSyncDownTime(R.string.sync_message_completed, DateUtils.formatDateForSync(manager.getLastSyncDown()));
        }
        if (manager.getLastSyncCatalog() <= 0) {
            mView.setSyncCatalogTime(R.string.sync_message_never);
        } else {
            mView.setSyncCatalogTime(R.string.sync_message_completed, DateUtils.formatDateForSync(manager.getLastSyncCatalog()));
        }

        initCatalogUpdate();
    }

    @Override
    public void synchronizeDown() {
        SyncManager.syncDown();
    }

    @Override
    public void synchronizeCatalog() {
        if (!isSyncRunning) {
            syncCatalogs();
        }
    }

    @Override
    public void startSyncUp() {
        if (isSyncRunning || SyncManager.isRunning()) {
            mView.showSyncRunning();
        } else {
            mView.startSyncUp();
        }
    }

    @Override
    public void onContinue() {
        if (isSyncRunning || SyncManager.isRunning()) {
            mView.showSyncRunning();
        } else if (!canFinish) {
            synchronizeCatalog();
        } else {
            mView.exit();
        }
    }

    @Override
    public void registerReceiver() {
        LocalBroadcastManager.getInstance(LibCore.getApplicationContext()).registerReceiver(syncBroadcastReceiver, new IntentFilter(SyncManager.ACTION_SYNC_STATUS));
    }

    @Override
    public void unregisterReceiver() {
        LocalBroadcastManager.getInstance(LibCore.getApplicationContext()).unregisterReceiver(syncBroadcastReceiver);
    }

    @Override
    public void onTryToExit() {
        if (isSyncRunning || SyncManager.isRunning()) {
            mView.showSyncRunning();
        } else if (!canFinish) {
            mView.showRetryPlease();
        } else {
            mView.exit();
        }
    }

    private void initCatalogUpdate() {
        if (InitManager.needCatalogUpdate() || InitManager.needPostalCodeUpdate()) {
            syncCatalogs();
        } else {
            canFinish = true;
        }
    }

    private void syncCatalogs() {
        isSyncRunning = true;
        mView.showCatalogsSync();
        mInitializeAppUseCase.execute(new Integer[]{R.raw.catalogos, R.raw.postalcodes}, new DisposableObserver<Boolean>() {
            @Override
            public void onNext(@NonNull Boolean aBoolean) {
                if (aBoolean) {
                    SessionManager.getInstance().saveLastSyncCatalog();
                    mView.showCatalogsSynced(R.string.sync_message_completed, DateUtils.formatDateForSync(manager.getLastSyncCatalog()));
                    canFinish = true;
                } else {
                    mView.showCatalogSyncError();
                }
            }

            @Override
            public void onError(@NonNull Throwable e) {
                mView.showCatalogSyncError();
                isSyncRunning = false;
            }

            @Override
            public void onComplete() {
                isSyncRunning = false;
                mView.showContinue(!SyncManager.isRunning(), !canFinish);

            }
        });
    }

    private BroadcastReceiver syncBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            Bundle extras = intent.getExtras();
            if (extras != null) {
                int result = extras.getInt(SyncManager.EXTRA_STATUS);
                switch (result) {
                    case SyncManager.SYNC_IS_RUNNING:
                    case SyncManager.SYNC_STARTED:
                        mView.startSyncAnimation(R.string.sync_message_started);
                        break;
                    case SyncManager.SYNC_NOT_REQUIRED:
                    case SyncManager.SYNC_COMPLETED:
                        mView.stopSyncAnimation(R.string.sync_message_completed, DateUtils.formatDateForSync(manager.getLastSyncDown()));
                        mView.showContinue(!isSyncRunning && !SyncManager.isRunning(), !canFinish);
                        break;
                    case SyncManager.SYNC_CONNECTION_ERROR:
                        mView.stopSyncAnimation(R.string.sync_message_network_error);
                        mView.setSyncUpTime(R.string.sync_message_network_error);
                        break;
                    case SyncManager.SYNC_GENERIC_ERROR:
                        mView.showSyncDownloadError();
                        mView.stopSyncAnimation(R.string.sync_message_download_generic_error);
                        mView.setSyncUpTime(R.string.sync_message_download_generic_error);
                        break;
                    case SyncManager.SYNC_ITEM_ERROR:
                        int errorId = extras.getInt(SyncManager.EXTRA_DATA);
                        mView.showSyncItemError(errorId);
                        mView.stopSyncAnimation(R.string.sync_message_download_generic_error);
                        mView.setSyncUpTime(R.string.sync_message_download_generic_error);
                        break;
                    default:
                        mView.stopSyncAnimation(R.string.sync_title);
                        Log.e("syncBroadcastReceiver::Error:" + SyncManager.getErrorString(result));
                }
            }
        }
    };
}
