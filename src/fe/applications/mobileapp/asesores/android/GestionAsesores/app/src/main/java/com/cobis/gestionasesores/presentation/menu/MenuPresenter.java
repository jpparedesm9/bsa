package com.cobis.gestionasesores.presentation.menu;

import android.util.SparseIntArray;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.NetworkUtils;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.enums.SyncItemType;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.domain.businesslogic.InitManager;
import com.cobis.gestionasesores.domain.usecases.GetPendingSyncItemCountUseCase;
import com.cobis.gestionasesores.infrastructure.SessionManager;

import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;

class MenuPresenter implements MenuContract.Presenter {
    private final MenuContract.View mView;
    private GetPendingSyncItemCountUseCase pendingSyncItemCountUseCase;

    MenuPresenter(MenuContract.View mView) {
        this.mView = mView;
        this.mView.setPresenter(this);
        this.pendingSyncItemCountUseCase = new GetPendingSyncItemCountUseCase();
    }

    @Override
    public void start() {
        mView.selectDefaultMenuOption();
        if (SessionManager.getInstance().isSessionActive()) {
            mView.showSessionInfo(SessionManager.getInstance().getSession());
        }
        checkSync();
    }

    @Override
    public void onDrawerOptionCustomerClick() {
        mView.showCustomersFragment();
        mView.closeDrawer();
    }

    @Override
    public void onDrawerOptionGroupClick() {
        mView.showGroupsFragment();
        mView.closeDrawer();
    }

    @Override
    public void onDrawerOptionApplicationClick() {
        mView.closeDrawer();
        mView.showApplicationsFragment();
    }

    @Override
    public void onDrawerOptionSimulationClick() {
        mView.showSimulationFragment();
        mView.closeDrawer();
    }

    @Override
    public void onDrawerOptionDefaultClick() {
        mView.showDefaultFragment();
        mView.closeDrawer();
    }

    @Override
    public void onDrawerOptionTaskClick() {
        mView.showTaskFragment();
        mView.closeDrawer();
    }

    @Override
    public void onDrawerOptionSynchronizationClick() {
        mView.showSynchronizationActivity(false);
        mView.closeDrawer();
    }

    @Override
    public void onDrawerOptionSettingsClick() {
        mView.navigateToSettings();
        mView.closeDrawer();
    }

    @Override
    public void onOpenUploadClick() {
        mView.showUploadActivity();
    }

    @Override
    public void onOptionLogoutClick() {
        SessionManager.getInstance().closeSession();
        mView.logout();
    }

    private void checkSync() {
        if(InitManager.needCatalogUpdate() || InitManager.needPostalCodeUpdate()){
            mView.showSynchronizationActivity( true);
        } else if(NetworkUtils.isOnline()){
            final SparseIntArray pendingItemCount = new SparseIntArray();
            pendingItemCount.put(SyncItemType.CUSTOMER, 0);
            pendingItemCount.put(SyncItemType.PROSPECT, 0);
            pendingItemCount.put(SyncItemType.GROUP, 0);
            pendingItemCount.put(SyncItemType.INDIVIDUAL_APPLICATION, 0);
            pendingItemCount.put(SyncItemType.GROUP_APPLICATION, 0);
            pendingItemCount.put(SyncItemType.PAYMENT, 0);
            pendingItemCount.put(SyncItemType.GROUP_VERIFICATION, 0);
            pendingItemCount.put(SyncItemType.INDIVIDUAL_VERIFICATION, 0);

            mView.showLoading();
            pendingSyncItemCountUseCase.execute(pendingItemCount, new DisposableObserver<ResultData>() {
                @Override
                public void onNext(@NonNull ResultData resultData) {
                    if (resultData != null && resultData.getType() == ResultType.SUCCESS) {
                        int count = 0;
                        for (int i = 0; i < pendingItemCount.size(); i++) {
                            count += pendingItemCount.valueAt(i);
                        }
                        if (count > 0) {
                            mView.showSyncDialog(count);
                        }
                    }
                }

                @Override
                public void onError(@NonNull Throwable e) {
                }

                @Override
                public void onComplete() {
                    mView.hideLoading();
                }
            });
        }
        else{
            Log.i("Did not sync: No internet connection.");
        }
    }
}