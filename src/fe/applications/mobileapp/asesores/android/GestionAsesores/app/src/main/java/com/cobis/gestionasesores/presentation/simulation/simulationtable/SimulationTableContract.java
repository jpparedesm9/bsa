package com.cobis.gestionasesores.presentation.simulation.simulationtable;


import com.cobis.gestionasesores.data.models.MonthlyPayment;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

import java.util.List;

/**
 * Created by JosueOrtiz on 02/08/2017.
 */

public interface SimulationTableContract {

    interface SimulationTableView extends BaseView<SimulationTablePresenter> {
        void setContent(List<MonthlyPayment> monthlyPayments);
        void showInterestRate(double rate);
        void renderTable();
    }

    interface SimulationTablePresenter extends BasePresenter {
    }
}
