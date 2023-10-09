package com.cobiscorp.ecobis.clientviewer.impl;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.clientviewer.MaxDebtService;
import com.cobiscorp.ecobis.clientviewer.bl.MaxDebtManager;
import com.cobiscorp.ecobis.clientviewer.dto.MaxDebtDTO;

public class MaxDebtServiceImpl implements MaxDebtService  {

	public MaxDebtManager maxDebtManager;
	
	private static ILogger logger = LogFactory
			.getLogger(MaxDebtServiceImpl.class);

	public MaxDebtDTO getMaxDebt(Integer customerCode, Integer groupCode) {
		try {
			logger.logDebug("Inicia getMaxDebt");
			return maxDebtManager.getMaxDebt(customerCode, groupCode);
		} finally {
			logger.logDebug("Fin getMaxDebt");
		}
	}

	public void setMaxDebtManager(MaxDebtManager maxDebtManager) {
		this.maxDebtManager = maxDebtManager;
	}
}
