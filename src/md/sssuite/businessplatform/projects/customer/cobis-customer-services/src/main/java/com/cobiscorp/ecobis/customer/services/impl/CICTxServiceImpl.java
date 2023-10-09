package com.cobiscorp.ecobis.customer.services.impl;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.customer.bl.CICManager;
import com.cobiscorp.ecobis.customer.services.CICTxService;
import com.cobiscorp.ecobis.customer.services.dtos.*;

public class CICTxServiceImpl implements CICTxService{

	private static ILogger logger = LogFactory.getLogger(CICTxServiceImpl.class);
	
	private CICManager cicManager; 
	
	@Override
	public CustomerDataResponse getCIC(CustomerQuickCreateRequest request) {
		logger.logInfo("in to CICTxServiceImpl");
		CustomerDataResponse resp = cicManager.getCIC(request);	
		return resp;
	}

	public CICManager getCicManager() {
		return cicManager;
	}

	public void setCicManager(CICManager cicManager) {
		this.cicManager = cicManager;
	}

	
	
}
