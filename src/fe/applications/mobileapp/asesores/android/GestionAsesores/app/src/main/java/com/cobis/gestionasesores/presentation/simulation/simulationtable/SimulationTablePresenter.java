package com.cobis.gestionasesores.presentation.simulation.simulationtable;

import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.data.models.MonthlyPayment;
import com.cobis.gestionasesores.data.models.SimulationResult;

import java.util.List;

/**
 * Created by Josue on 02/08/2017.
 * Tables were made based on this:
 * https://www.androidcode.ninja/android-scroll-table-fixed-header-column/
 */

public class SimulationTablePresenter implements SimulationTableContract.SimulationTablePresenter {
    private SimulationTableContract.SimulationTableView mView;
    private SimulationResult mSimulationResult;

    public SimulationTablePresenter(SimulationTableContract.SimulationTableView view, SimulationResult simulationResult) {
        mView = view;
        mSimulationResult = simulationResult;
        mView.setPresenter(this);
    }

    @Override
    public void start() {
        mView.setContent(mSimulationResult.getMonthlyPayments());
        mView.showInterestRate(mSimulationResult.getRate());
        mView.renderTable();
    }
}
