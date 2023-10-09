package com.cobiscorp.ecobis.customer.services.impl;

import com.cobiscorp.ecobis.customer.bl.PadronManager;
import com.cobiscorp.ecobis.customer.services.PadronTxService;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerQuickCreateRequest;

public class PadronTxServiceImpl implements PadronTxService {

	private PadronManager padronManager;

	public PadronManager getPadronManager() {
		return padronManager;
	}

	public void setPadronManager(PadronManager padronManager) {
		this.padronManager = padronManager;
	}

	@Override
	public CustomerDataResponse executePadronSearch(
			CustomerQuickCreateRequest request) {
		CustomerDataResponse resp = padronManager.getPadronCustomer(request);
		return resp;
		
		
		
		
	}

}
