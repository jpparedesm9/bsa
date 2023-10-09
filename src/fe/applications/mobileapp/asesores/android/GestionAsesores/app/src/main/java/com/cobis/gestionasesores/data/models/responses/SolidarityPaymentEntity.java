package com.cobis.gestionasesores.data.models.responses;

import java.util.List;

public class SolidarityPaymentEntity {
    private List<SolidarityPaymentCustomerData> solidarityPaymentCustomerData;
    private SolidarityPaymentData solidarityPaymentData;

    public List<SolidarityPaymentCustomerData> getSolidarityPaymentCustomerData() {
        return solidarityPaymentCustomerData;
    }

    public void setSolidarityPaymentCustomerData(List<SolidarityPaymentCustomerData> solidarityPaymentCustomerData) {
        this.solidarityPaymentCustomerData = solidarityPaymentCustomerData;
    }

    public SolidarityPaymentData getSolidarityPaymentData() {
        return solidarityPaymentData;
    }

    public void setSolidarityPaymentData(SolidarityPaymentData solidarityPaymentData) {
        this.solidarityPaymentData = solidarityPaymentData;
    }
}
