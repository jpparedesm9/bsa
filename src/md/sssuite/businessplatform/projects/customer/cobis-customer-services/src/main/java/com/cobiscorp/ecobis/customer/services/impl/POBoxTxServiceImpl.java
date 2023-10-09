package com.cobiscorp.ecobis.customer.services.impl;

import java.util.List;

import com.cobiscorp.ecobis.customer.services.POBoxTxService;
import com.cobiscorp.ecobis.customer.services.dtos.*;
import com.cobiscorp.ecobis.customer.bl.POBoxManager;

public class POBoxTxServiceImpl implements POBoxTxService{
	
	POBoxManager poBoxManager;
	
	public POBoxManager getPoBoxManager() {
		return poBoxManager;
	}

	public void setPoBoxManager(POBoxManager poBoxManager) {
		this.poBoxManager = poBoxManager;
	}

	public List<POBoxDataResponse> getAllPOBOX(CustomerDataRequest request) {
		List<POBoxDataResponse> listAllPOBox = poBoxManager.getAllPOBOX(request);
		return listAllPOBox;
	}
}
