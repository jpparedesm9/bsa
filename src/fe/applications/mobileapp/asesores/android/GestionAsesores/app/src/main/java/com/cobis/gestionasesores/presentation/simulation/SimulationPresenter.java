package com.cobis.gestionasesores.presentation.simulation;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.NetworkUtils;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.enums.Catalog;
import com.cobis.gestionasesores.data.enums.FrequencyType;
import com.cobis.gestionasesores.data.enums.SimulationType;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.SimulationData;
import com.cobis.gestionasesores.data.models.SimulationResult;
import com.cobis.gestionasesores.data.repositories.CatalogRepository;
import com.cobis.gestionasesores.domain.usecases.ComputeAmortizationTableUseCase;
import com.cobis.gestionasesores.utils.Util;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by JosueOrtiz on 01/08/2017.
 */

public class SimulationPresenter implements SimulationContract.SimulationPresenter {
    private SimulationContract.SimulationView mView;
    private ComputeAmortizationTableUseCase mUseCase;
    private List<CatalogItem> mFrequencyItemsCatalog;
    private boolean mIsOnline;

    public SimulationPresenter(SimulationContract.SimulationView view, ComputeAmortizationTableUseCase userCase) {
        mView = view;
        mUseCase = userCase;
        mView.setPresenter(this);
    }

    @Override
    public void start() {
        mIsOnline = NetworkUtils.isOnline();
        loadCatalogs();
    }

    private void initialize() {
        mView.resetFields();
        mView.setDate(Calendar.getInstance().getTimeInMillis());
        if(!mIsOnline){
            mView.setCreditType(SimulationType.INDIVIDUAL);
            mView.enableCreditType(false);
            mView.showInterest(true);
        }else{
            mView.enableCreditType(true);
            mView.showInterest(false);
        }
    }

    public boolean validateData(SimulationData data) {
        boolean isValid = true;

        if (data.getAmount() == 0) {
            isValid = false;
            mView.showAmountError();
        }

        if (StringUtils.isEmpty(data.getTerm())){
            isValid = false;
            mView.showTimeLimitError();
        }

        if (data.getDate() == null) {
            isValid = false;
            mView.showDateFormatError();
        }

        if (data.getInterest() < 0 && !mIsOnline) {
            isValid = false;
            mView.showInterestError();
        }

        if (StringUtils.isEmpty(data.getCreditType())) {
            isValid = false;
            mView.showCreditTypeError();
        }

        if (StringUtils.isEmpty(data.getFrequency())) {
            isValid = false;
            mView.showFrequencyError();
        }

        return isValid;
    }


    @Override
    public void resetSimulation() {
        mView.cleanAllErrors();
        initialize();
    }

    @Override
    public void simulate(SimulationData data) {
        mView.cleanAllErrors();
        if (validateData(data)) {
            mView.showLoading();
            data.setTryOnline(mIsOnline);
            mUseCase.execute(data, new DisposableObserver<SimulationResult>() {
                @Override
                public void onNext(@NonNull SimulationResult simulationResult) {
                    if (simulationResult.isSuccess()) {
                        mView.showResult(simulationResult);
                    } else {
                        mView.showComputeError(simulationResult.getError() != null ? simulationResult.getError().getMessage() : null);
                    }
                }

                @Override
                public void onError(@NonNull Throwable e) {
                    mView.hideLoading();
                    if (Util.isNetworkError(e)) {
                        mView.showNetworkError();
                    } else {
                        mView.showComputeError(null);
                    }
                }

                @Override
                public void onComplete() {
                    mView.hideLoading();
                }
            });
        }
    }

    @Override
    public void onCreditTypeChange(String code) {
        if (mFrequencyItemsCatalog == null) return;
        if (SimulationType.GROUP.equals(code)) {
            List<CatalogItem> tmp = new ArrayList<>();
            for (CatalogItem item : mFrequencyItemsCatalog) {
                if (item.getCode().equals(FrequencyType.WEEKLY)) {
                    tmp.add(item);
                }
            }
            mView.showCreditFrequencyCatalog(tmp);
            mView.setFrequency(FrequencyType.WEEKLY);
            mView.enableFrequency(false);
        } else {
            mView.showCreditFrequencyCatalog(mFrequencyItemsCatalog);
            mView.setFrequency(null);
            mView.enableFrequency(true);
        }
    }

    @Override
    public void onClickOpeningDate() {
        mView.showOpeningDateDialog(null);
    }

    @Override
    public void onOpeningDateSet(int year, int month, int dayOfMonth) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(year, month, dayOfMonth);
        mView.setOpeningDate(calendar.getTimeInMillis());
    }

    public void loadCatalogs() {
        @Catalog int[] catalogs = new int[]{Catalog.CAT_CREDIT_FREQUENCY,
                Catalog.CAT_CREDIT_TYPE,
                Catalog.CAT_SIMULATOR_TERM};
        CatalogRepository.getInstance().getCatalogItemsByCodes(catalogs).subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<Map<Integer, List<CatalogItem>>>() {
                    @Override
                    public void onNext(@NonNull Map<Integer, List<CatalogItem>> integerListMap) {
                        for (Map.Entry<Integer, List<CatalogItem>> entry : integerListMap.entrySet()) {
                            handleCatalogItems(entry.getKey(), entry.getValue());
                        }
                        initialize();
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        Log.e("SimulationPresenter: Error loadCatalogs! ", e);
                    }

                    @Override
                    public void onComplete() {
                    }
                });
    }

    private void handleCatalogItems(int code, List<CatalogItem> items) {
        switch (code) {
            case Catalog.CAT_CREDIT_FREQUENCY:
                mFrequencyItemsCatalog = items;
                mView.showCreditFrequencyCatalog(items);
                break;
            case Catalog.CAT_CREDIT_TYPE:
                mView.showCreditTypeCatalog(items);
                break;
            case Catalog.CAT_SIMULATOR_TERM:
                mView.showTermMonthsCatalog(items);
                break;
        }
    }

    @Override
    public void onInternetChangeState(boolean b) {
        start();
    }

}
