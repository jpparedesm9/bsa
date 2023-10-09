package com.cobis.tuiiob2c.data.models;

public class CommissionCalculateValues {

    private String commission;
    private String iva;
    private String valueToReceive;

    public CommissionCalculateValues() {
    }

    public CommissionCalculateValues(String commission, String iva, String valueToReceive) {
        this.commission = commission;
        this.iva = iva;
        this.valueToReceive = valueToReceive;
    }

    public String getCommission() {
        return commission;
    }

    public void setCommission(String commission) {
        this.commission = commission;
    }

    public String getIva() {
        return iva;
    }

    public void setIva(String iva) {
        this.iva = iva;
    }

    public String getValueToReceive() {
        return valueToReceive;
    }

    public void setValueToReceive(String valueToReceive) {
        this.valueToReceive = valueToReceive;
    }
}