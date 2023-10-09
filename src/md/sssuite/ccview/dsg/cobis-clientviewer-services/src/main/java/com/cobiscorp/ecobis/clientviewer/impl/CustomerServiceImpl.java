package com.cobiscorp.ecobis.clientviewer.impl;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.clientviewer.ICustomerService;
import com.cobiscorp.ecobis.clientviewer.bl.CustomerManager;
import com.cobiscorp.ecobis.customer.commons.dto.CustomerInformationDTO;

public class CustomerServiceImpl implements ICustomerService {

	public CustomerManager customerManager;

	private static ILogger logger = LogFactory
			.getLogger(CustomerServiceImpl.class);

	@Override
	public CustomerInformationDTO getCustomer(Integer customerCode) {
		try {
			logger.logDebug("Inicia getCustomerType");
			return customerManager.getCustomer(customerCode);
		} finally {
			logger.logDebug("Finaliza getCustomerType");
		}
	}

	@Override
	public CustomerInformationDTO getGroupDetail(Integer groupCode, String type) {
		try {
			logger.logDebug("Inicia getGroupDetail");
			return customerManager.getGroupDetail(groupCode, type);
		} finally {
			logger.logDebug("Inicia getGroupDetail");
		}
	}

	public CustomerManager getCustomerManager() {
		return customerManager;
	}

	public void setCustomerManager(CustomerManager customerManager) {
		this.customerManager = customerManager;
	}

}
