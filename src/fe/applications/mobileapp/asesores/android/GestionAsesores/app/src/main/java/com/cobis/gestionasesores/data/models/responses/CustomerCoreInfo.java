package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by User on 17/08/2017.
 */

public class CustomerCoreInfo {
    private String customerAccountId;
    private String customerStdCode;

    public CustomerCoreInfo() {
    }

    public String getCustomerAccountId() {
        return customerAccountId;
    }

    public void setCustomerAccountId(String customerAccountId) {
        this.customerAccountId = customerAccountId;
    }

    public String getCustomerStdCode() {
        return customerStdCode;
    }

    public void setCustomerStdCode(String customerStdCode) {
        this.customerStdCode = customerStdCode;
    }

    @Override
    public String toString() {
        return "CustomerCoreInfo{" +
                "customerAccountId='" + customerAccountId + '\'' +
                ", customerStdCode='" + customerStdCode + '\'' +
                '}';
    }
}
