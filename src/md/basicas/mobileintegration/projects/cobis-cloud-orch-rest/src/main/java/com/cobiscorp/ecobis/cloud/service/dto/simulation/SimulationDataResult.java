package com.cobiscorp.ecobis.cloud.service.dto.simulation;

public class SimulationDataResult {

    public static class SimulationResult {}
    private Double rate;
    private AmortizationEntry[] amortizationTable;

    public SimulationDataResult() {
    }

    public SimulationDataResult(Double rate, AmortizationEntry[] amortizationTable) {
        this.rate = rate;
        this.amortizationTable = amortizationTable;
    }

    public Double getRate() {
        return rate;
    }

    public void setRate(Double rate) {
        this.rate = rate;
    }

    public AmortizationEntry[] getAmortizationTable() {
        return amortizationTable;
    }

    public void setAmortizationTable(AmortizationEntry[] amortizationTable) {
        this.amortizationTable = amortizationTable;
    }
}
