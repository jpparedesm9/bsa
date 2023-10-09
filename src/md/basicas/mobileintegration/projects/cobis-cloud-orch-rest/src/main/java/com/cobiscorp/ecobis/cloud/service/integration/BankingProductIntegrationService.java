package com.cobiscorp.ecobis.cloud.service.integration;

import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class BankingProductIntegrationService extends BaseEvent {

	private final ILogger LOGGER = LogFactory.getLogger(BankingProductIntegrationService.class);

	public BankingProductIntegrationService(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	public List<GeneralParametersValuesHistory> getCatalogGeneralParameter(String productId, String parameterName) throws Exception {
		LOGGER.logDebug("Start getCatalogGeneralParameter in BankingProductIntegrationService");
		Object object[] = new Object[2];
		object[0] = productId;
		object[1] = parameterName;
		try {
			ServiceResponse serviceResponse = this.execute(LOGGER, "FPM.Operation.FindGeneralParameterValuesDescription", object);
			return (List<GeneralParametersValuesHistory>) serviceResponse.getData();
		} finally {
			LOGGER.logDebug("Finish getCatalogGeneralParameter in BankingProductIntegrationService");
		}
	}

}
