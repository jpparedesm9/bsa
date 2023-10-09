package com.cobis.gestionasesores.presentation.simulation;

import android.view.View;

import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.MonthlyPayment;
import com.cobis.gestionasesores.data.models.SimulationData;
import com.cobis.gestionasesores.data.models.SimulationResult;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

import java.util.List;

/**
 * Created by JosueOrtiz on 01/08/2017.
 *
 */

public interface SimulationContract {

    interface SimulationView extends BaseView<SimulationPresenter> {
        void onClickCalculate(View view);

        void showInterestError();

        void onClickCleanFields(View view);

        void cleanAllErrors();

        void showAmountError();

        void showInterestOutOfBoundsError();

        void showTimeLimitError();

        void showCreditFrequencyCatalog(List<CatalogItem> frequencyType);

        void showCreditTypeCatalog(List<CatalogItem> creditType);

        void showTermMonthsCatalog(List<CatalogItem> termMonths);

        void setDate(Long date);

        void showDateFormatError();

        void showOpeningDateDialog(Long maxDate);

        void setOpeningDate(Long date);

        void onClickOpeningDate(View view);

        void showLoading();

        void hideLoading();

        void resetFields();

        void showCreditTypeError();

        void showFrequencyError();

        void showNetworkError();

        void showResult(SimulationResult simulationResult);

        void showComputeError(String message);

        void setCreditType(String type);

        void enableCreditType(boolean enable);

        void setFrequency(String frequency);

        void enableFrequency(boolean enable);

        void showInterest(boolean show);
    }

    interface SimulationPresenter extends BasePresenter {
        void onClickOpeningDate();

        void onOpeningDateSet(int year, int month, int dayOfMonth);

        void resetSimulation();

        void simulate(SimulationData data);

        void onCreditTypeChange(String code);

        void onInternetChangeState(boolean b);
    }
}

