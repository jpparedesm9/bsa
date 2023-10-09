package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.requests.SimulationRow;

import java.util.List;

/**
 * Created by mnaunay on 09/08/2017.
 */

public class SimulationRemote {
    private double rate;
    private List<SimulationRow> amortizationTable;

    public double getRate() {
        return rate;
    }

    public void setRate(double rate) {
        this.rate = rate;
    }

    public List<SimulationRow> getAmortizationTable() {
        return amortizationTable;
    }

    public void setAmortizationTable(List<SimulationRow> amortizationTable) {
        this.amortizationTable = amortizationTable;
    }
}
