package com.cobiscorp.ecobis.assets.dto;

import java.util.List;

public class SolidarityPaymentCustomerRequest {

	private List<SolidarityPaymentCustomerData> solidarityCustomerData;

	public List<SolidarityPaymentCustomerData> getSolidarityCustomerData() {
		return solidarityCustomerData;
	}

	public void setSolidarityCustomerData(List<SolidarityPaymentCustomerData> solidarityCustomerData) {
		this.solidarityCustomerData = solidarityCustomerData;
	}

}
