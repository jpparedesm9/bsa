package com.cobiscorp.ecobis.customer.services.impl;


import java.util.List;

import com.cobiscorp.ecobis.customer.bl.IdCustomerManager;
import com.cobiscorp.ecobis.customer.services.IdCustomerTxService;
import com.cobiscorp.ecobis.customer.services.dtos.IdCustomerDataResponse;


public class IdCreateTxServiceImpl  implements IdCustomerTxService{
	
	private IdCustomerManager idCustomerManager;
	

	@Override
	public List<IdCustomerDataResponse> executeIdCustomer (IdCustomerDataResponse request) {
		
		List<IdCustomerDataResponse> resp = idCustomerManager.getIdCustomer(request);
	
		return resp;
	}


	public IdCustomerManager getIdCustomerManager() {
		return idCustomerManager;
	}


	public void setIdCustomerManager(IdCustomerManager idCustomerManager) {
		this.idCustomerManager = idCustomerManager;
	}


}
