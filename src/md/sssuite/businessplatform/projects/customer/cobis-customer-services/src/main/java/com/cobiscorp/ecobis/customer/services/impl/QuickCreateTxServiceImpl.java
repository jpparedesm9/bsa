package com.cobiscorp.ecobis.customer.services.impl;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.customer.bl.QuickCustomerManager;
import com.cobiscorp.ecobis.customer.services.QuickCreateTxService;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerQuickCreateRequest;
import com.cobiscorp.ecobis.customer.util.StoreProcedureExecutor;


public class QuickCreateTxServiceImpl implements QuickCreateTxService  {
	
	private static ILogger logger = LogFactory.getLogger(StoreProcedureExecutor.class);
	
	private QuickCustomerManager quickCustomerManager ;
	
	public CustomerDataResponse executeQuickCreate( CustomerQuickCreateRequest request ){
		logger.logInfo("in to QuickCreateTxServiceImpl");
		CustomerDataResponse resp = quickCustomerManager.getQuickCustomer(request);
		return resp;
	}

	public QuickCustomerManager getQuickCustomerManager() {
		return quickCustomerManager;
	}

	public void setQuickCustomerManager(QuickCustomerManager quickCustomerManager) {
		this.quickCustomerManager = quickCustomerManager;
	}

	

}
