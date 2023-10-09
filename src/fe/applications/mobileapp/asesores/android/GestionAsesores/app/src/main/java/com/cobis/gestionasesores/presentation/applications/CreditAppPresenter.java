package com.cobis.gestionasesores.presentation.applications;


import android.annotation.SuppressLint;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.Constants;
import com.cobis.gestionasesores.data.enums.CreditAppType;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.mappers.GroupCreditAppMapper;
import com.cobis.gestionasesores.data.mappers.IndividualCreditMapper;
import com.cobis.gestionasesores.data.models.CreditApp;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.repositories.CreditAppRepository;

import java.util.List;
import java.util.concurrent.TimeUnit;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by bqtdesa02 on 6/22/2017.
 */

public class CreditAppPresenter implements CreditAppContract.ApplicationsPresenter {
    private CreditAppContract.ApplicationsView mView;
    private String mLastKeyword;
    @CreditAppType
    private String mLastCreditType  = CreditAppType.UNKNOWN;

    public CreditAppPresenter(CreditAppContract.ApplicationsView view) {
        mView = view;
        mView.setPresenter(this);
    }

    @Override
    public void start() {
        mLastKeyword = "";
        mView.clearSearch();
        loadCreditApps(mLastCreditType);
    }

    @Override
    public void onRefresh() {
        if (StringUtils.isNotEmpty(mLastKeyword)) {
            onSearchChange(mLastKeyword);
        } else {
            loadCreditApps(mLastCreditType);
        }
    }

    @SuppressLint("CheckResult")
    @Override
    public void onSearchChange(String query) {
        mLastKeyword = query;
        mView.showLoadingIndicator();
        CreditAppRepository.getInstance().search(mLastKeyword, mLastCreditType, SyncStatus.UNKNOWN)
                .debounce(Constants.DEBOUNCE_TIME, TimeUnit.MILLISECONDS)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<List<CreditApp>>() {
                    @Override
                    public void onNext(@NonNull List<CreditApp> creditApps) {
                        if (creditApps.isEmpty()) {
                            mView.clearResults();
                            mView.showNoResultsFound();
                        } else {
                            mView.showCreditApps(creditApps);
                        }
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        mView.clearResults();
                        mView.showSearchError();
                    }

                    @Override
                    public void onComplete() {
                        mView.hideLoadingIndicator();
                    }
                });
    }

    @SuppressLint("CheckResult")
    @Override
    public void loadCreditApps(final String creditAppType) {
        mLastCreditType = creditAppType;
        mView.showLoadingIndicator();
        CreditAppRepository.getInstance()
                .getAll(mLastCreditType,SyncStatus.UNKNOWN)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<List<CreditApp>>() {
                    @Override
                    public void onNext(@NonNull List<CreditApp> creditApps) {
                        if (creditApps.isEmpty()) {
                            mView.showCreditAppsEmpty();
                        } else {
                            mView.showCreditApps(creditApps);
                        }
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        mView.showLoadCreditAppsError();
                    }

                    @Override
                    public void onComplete() {
                        mView.hideLoadingIndicator();
                    }
                });
    }

    @Override
    public void onGroupSelected(Group group) {
        mView.startGroupCreditApp(GroupCreditAppMapper.fromGroup(group));
    }

    @Override
    public void onCustomerSelected(Person person) {
        mView.startIndividualCreditApp(IndividualCreditMapper.fromCustomer(person));
    }
}
