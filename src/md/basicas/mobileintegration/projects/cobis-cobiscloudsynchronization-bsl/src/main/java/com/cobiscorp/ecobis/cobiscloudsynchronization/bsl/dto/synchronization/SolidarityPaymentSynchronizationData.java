package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization;

import com.cobiscorp.ecobis.cloud.service.dto.solidaritypayment.SolidarityPaymentCustomerData;
import com.cobiscorp.ecobis.cloud.service.dto.solidaritypayment.SolidarityPaymentData;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

/**
 * Created by farid on 7/21/2017.
 */
@XmlRootElement(name = "solidarityPaymentSinchronizationData")
public class SolidarityPaymentSynchronizationData {

    private List<SolidarityPaymentCustomerData> solidarityPaymentCustomerData;
    private SolidarityPaymentData solidarityPaymentData;

    public SolidarityPaymentSynchronizationData() {
    }

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
