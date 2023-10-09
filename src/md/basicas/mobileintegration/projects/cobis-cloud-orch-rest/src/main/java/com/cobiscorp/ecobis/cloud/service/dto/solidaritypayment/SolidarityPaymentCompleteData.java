package com.cobiscorp.ecobis.cloud.service.dto.solidaritypayment;

import java.util.List;

/**
 * Created by farid on 7/24/2017.
 */
public class SolidarityPaymentCompleteData {
    private SolidarityPaymentData solidarityPaymentData;
    private List<SolidarityPaymentCustomerData> solidarityPaymentCustomerData;

    public SolidarityPaymentCompleteData() {
    }

    public SolidarityPaymentData getSolidarityPaymentData() {
        return solidarityPaymentData;
    }

    public void setSolidarityPaymentData(SolidarityPaymentData solidarityPaymentData) {
        this.solidarityPaymentData = solidarityPaymentData;
    }

    public List<SolidarityPaymentCustomerData> getSolidarityPaymentCustomerData() {
        return solidarityPaymentCustomerData;
    }

    public void setSolidarityPaymentCustomerData(List<SolidarityPaymentCustomerData> solidarityPaymentCustomerData) {
        this.solidarityPaymentCustomerData = solidarityPaymentCustomerData;
    }
}
