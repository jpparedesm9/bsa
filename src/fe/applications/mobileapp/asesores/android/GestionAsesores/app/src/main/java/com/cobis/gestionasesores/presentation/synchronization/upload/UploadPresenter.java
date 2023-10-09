package com.cobis.gestionasesores.presentation.synchronization.upload;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.support.v4.content.LocalBroadcastManager;
import android.util.SparseIntArray;

import com.bayteq.libcore.LibCore;
import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.enums.SyncItemType;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.SyncData;
import com.cobis.gestionasesores.domain.usecases.GetPendingSyncItemCountUseCase;
import com.cobis.gestionasesores.infrastructure.SessionManager;
import com.cobis.gestionasesores.infrastructure.SyncManager;
import com.cobis.gestionasesores.utils.DateUtils;
import com.cobis.gestionasesores.utils.ResourcesUtil;

import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;

import static com.cobis.gestionasesores.infrastructure.SyncManager.EXTRA_DATA;

public class UploadPresenter implements UploadContract.Presenter {

    private SessionManager manager;
    private UploadContract.View mView;
    private GetPendingSyncItemCountUseCase pendingSyncItemCountUseCase;
    private int mTotalSyncCount = 0;

    public UploadPresenter(UploadContract.View view, GetPendingSyncItemCountUseCase getPendingSyncItemCountUseCase) {
        mView = view;
        mView.setPresenter(this);
        pendingSyncItemCountUseCase = getPendingSyncItemCountUseCase;
    }

    @Override
    public void start() {
        manager = SessionManager.getInstance();
        if (manager.getLastSyncUp() <= 0) {
            mView.setSyncText(R.string.sync_message_never);
        } else {
            mView.setSyncText(R.string.sync_message_completed, DateUtils.formatDateForSync(manager.getLastSyncUp()));
        }
        if (SyncManager.isRunning()) {
            mView.showProgressBar();
        }

        boolean[] uploadItems = new boolean[mView.getUploadItems().length];
        for (int i = 0; i < uploadItems.length; i++) {
            uploadItems[i] = true;
        }
        updateItemCount(uploadItems);
    }

    @Override
    public void startSynchronization(boolean[] items) {
        final SparseIntArray pendingItemCount = getPendingItemCount(items);
        if (pendingItemCount.size() == 0) {
            mView.appendDetail(R.string.synchronization_no_items_selected);
        } else if (mTotalSyncCount > 0) {
            startSynchronization(pendingItemCount);
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
        if (SyncManager.isRunning()) {
            mView.showSyncRunning();
        } else {
            mView.exit();
        }
    }

    @Override
    public boolean handleMenuSettings() {
        if (SyncManager.isRunning()) {
            mView.showSyncRunning();
            return false;
        } else {
            mView.openMenuSettings();
            return true;
        }
    }

    @Override
    public void onSelectUploadItems(boolean[] uploadItems) {
        updateItemCount(uploadItems);
    }

    @Override
    public void onClickFinish() {
        onTryToExit();
    }

    private void startSynchronization(SparseIntArray itemCount) {
        if (itemCount != null && itemCount.size() > 0) {
            int[] items = new int[itemCount.size()];
            for (int i = 0; i < itemCount.size(); i++) {
                items[i] = itemCount.keyAt(i);
            }
            SyncManager.syncUp(items);
        }
    }

    private void updateItemCount(boolean[] items) {
        mView.clearDetails();

        final SparseIntArray pendingItemCount = getPendingItemCount(items);

        if (pendingItemCount.size() > 0) {
            mView.showLoading();
            pendingSyncItemCountUseCase.execute(pendingItemCount, new DisposableObserver<ResultData>() {
                @Override
                public void onNext(@NonNull ResultData resultData) {
                    if (resultData != null && resultData.getType() == ResultType.SUCCESS) {
                        mTotalSyncCount = 0;
                        for (int i = 0; i < pendingItemCount.size(); i++) {
                            mTotalSyncCount += pendingItemCount.valueAt(i);
                            mView.appendDetailWithResourceArg(R.string.synchronization_detail_item_count, ResourcesUtil.getSyncItemResource(pendingItemCount.keyAt(i)), pendingItemCount.valueAt(i));
                        }
                        mView.appendDetail(R.string.synchronization_total_item_count, mTotalSyncCount);

                    } else {
                        mView.appendDetail(R.string.synchronization_get_item_count_error);
                    }
                }

                @Override
                public void onError(@NonNull Throwable e) {
                    mView.appendDetail(R.string.synchronization_get_item_count_error);
                    mView.hideLoading();
                }

                @Override
                public void onComplete() {
                    mView.hideLoading();
                }
            });
        } else {
            mView.appendDetail(R.string.synchronization_no_items_selected);
        }
    }

    private SparseIntArray getPendingItemCount(boolean[] items) {
        SparseIntArray pendingItemCount = new SparseIntArray();
        if (items[0]) {
            pendingItemCount.put(SyncItemType.CUSTOMER, 0);
            pendingItemCount.put(SyncItemType.PROSPECT, 0);
            pendingItemCount.put(SyncItemType.GROUP, 0);
            pendingItemCount.put(SyncItemType.INDIVIDUAL_APPLICATION, 0);
            pendingItemCount.put(SyncItemType.GROUP_APPLICATION, 0);
            pendingItemCount.put(SyncItemType.PAYMENT, 0);
            pendingItemCount.put(SyncItemType.GROUP_VERIFICATION, 0);
            pendingItemCount.put(SyncItemType.INDIVIDUAL_VERIFICATION, 0);
        } else {
            if (items[1]) {
                pendingItemCount.put(SyncItemType.CUSTOMER, 0);
                pendingItemCount.put(SyncItemType.PROSPECT, 0);
            }
            if (items[2]) {
                pendingItemCount.put(SyncItemType.GROUP, 0);
            }
            if (items[3]) {
                pendingItemCount.put(SyncItemType.INDIVIDUAL_APPLICATION, 0);
                pendingItemCount.put(SyncItemType.GROUP_APPLICATION, 0);
            }
            if (items[4]) {
                pendingItemCount.put(SyncItemType.GROUP_VERIFICATION, 0);
                pendingItemCount.put(SyncItemType.INDIVIDUAL_VERIFICATION, 0);
            }
            if (items[5]) {
                pendingItemCount.put(SyncItemType.PAYMENT, 0);
            }
        }
        return pendingItemCount;
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
                        mView.showProgressBar();
                        mView.clearDetails();
                        mView.appendDetail(R.string.sync_message_started);
                        mView.showFinish(false);
                        break;
                    case SyncManager.SYNC_NOT_REQUIRED:
                    case SyncManager.SYNC_COMPLETED:
                        mView.appendDetail(R.string.sync_message_completed, DateUtils.formatDateForSync(manager.getLastSyncUp()));
                        mView.setSyncText(R.string.sync_message_completed, DateUtils.formatDateForSync(manager.getLastSyncUp()));
                        mView.hideProgressBar();
                        mView.showFinish(true);
                        mView.showFinishSuccess();
                        break;
                    case SyncManager.SYNC_CONNECTION_ERROR:
                        mView.appendDetail(R.string.sync_message_communication_error);
                        mView.hideProgressBar();
                        break;
                    case SyncManager.SYNC_GENERIC_ERROR:
                        mView.appendDetail(R.string.sync_message_generic_error);
                        mView.hideProgressBar();
                        break;
                    case SyncManager.SYNC_PROGRESS_UPDATE:
                        SyncData data = (SyncData) extras.getSerializable(EXTRA_DATA);
                        int typeRes;
                        if (data != null) {
                            typeRes = ResourcesUtil.getSyncItemResource(data.getItem());

                            if (data.isCopyLine()) {
                                mView.copyLastDetail();
                            }

                            if (data.getType() == ResultType.SUCCESS) {
                                switch (data.getAction()) {
                                    case APPEND:
                                        mView.appendDetailWithResourceArg(R.string.synchronization_msg_updating_type, typeRes, data.getFormatArgs());
                                        break;
                                    case UPDATE:
                                        mView.replaceLastDetailWithResourceArg(R.string.synchronization_msg_updating_type, typeRes, data.getFormatArgs());
                                        break;
                                }
                            } else {
                                switch (data.getAction()) {
                                    case APPEND:
                                        mView.appendDetailWithResourceArg(R.string.synchronization_error_updating_type, typeRes, data.getFormatArgs());
                                        break;
                                    case UPDATE:
                                        mView.replaceLastDetailWithResourceArg(R.string.synchronization_error_updating_type, typeRes, data.getFormatArgs());
                                        break;
                                }
                            }
                        }
                        break;
                    default:
                        mView.appendDetail(SyncManager.getErrorString(result));
                        mView.hideProgressBar();
                        Log.e("syncBroadcastReceiver::Error:" + SyncManager.getErrorString(result));
                }
            }
        }
    };
}
